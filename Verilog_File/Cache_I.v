module Cache_I (clk,rst_n,DataIn_FSM,DataOut_CPU,Miss,Addr_CPU,Addr_FSM,
MetaData_WE,Data_WE,stall_I);
output stall_I;
input clk;                      // clock
input rst_n;                    // active low reset
input [15:0] Addr_CPU;          // Address that cpu snet to cache to do the read&write
input [15:0] Addr_FSM;          // Address that FSM sent to cache to do the write.
input [15:0] DataIn_FSM;        // data sent from FSM

wire R;                        // read required
assign R = 1'b1;
input MetaData_WE;              // Metadata write enable from FSM 
input Data_WE;                  // Data write enable from FSM
output [15:0] DataOut_CPU;      // Dataoutput that CPU can see
output Miss;                    // Miss signal sent to FSM

/// internal wires                                                  // need to update metadata, schedule the write.
wire rst;                       
wire Left_D_WE;                 
wire Right_D_WE;
assign rst = !rst_n;

wire Left_M_WE_OUT;
wire Right_M_WE_OUT;

// left Data
wire[15:0] Left_D_IN;
wire[15:0] Left_D_OUT;
wire[7:0]  Left_D_WORD;
wire[127:0]Left_D_BE;
DataArray      Left_D (.clk(clk), .rst(rst), .DataIn(Left_D_IN),  .Write(Left_D_WE), 
.BlockEnable(Left_D_BE), .WordEnable(Left_D_WORD), .DataOut(Left_D_OUT));

// right Data
wire[15:0] Right_D_IN;
wire[15:0] Right_D_OUT;
wire[7:0]  Right_D_WORD;
wire[127:0]Right_D_BE;
DataArray      Right_D(.clk(clk), .rst(rst), .DataIn(Right_D_IN), .Write(Right_D_WE), 
.BlockEnable(Right_D_BE), .WordEnable(Right_D_WORD), .DataOut(Right_D_OUT));

// left Metadata
wire[7:0]  Left_M_IN;
wire[7:0]  Left_M_OUT;
wire[7:0]  Left_M_REG_OUT;
wire[127:0]Left_M_BE;
MetaDataArray  Left_M (.clk(clk), .rst(rst), .DataIn(Left_M_REG_OUT),  .Write(Left_M_WE_OUT), 
.BlockEnable(Left_M_BE), .DataOut(Left_M_OUT));

// right metadata
wire[7:0]  Right_M_IN;
wire[7:0]  Right_M_OUT;
wire[7:0]  Right_M_REG_OUT;
wire[127:0]Right_M_BE;
MetaDataArray  Right_M(.clk(clk), .rst(rst), .DataIn(Right_M_REG_OUT), .Write(Right_M_WE_OUT), 
.BlockEnable(Right_M_BE), .DataOut(Right_M_OUT));

// Miss Detection wires
wire[5:0]   SET = Addr_CPU[9:4];        // find out which set the data could be in.
wire[5:0]   SET_STALLED;                // stalled set
wire[5:0]   TAG = Addr_CPU[15:10];      // find out the CORRECT tag from CPU
wire[2:0]   OFFSET = Addr_CPU[3:1];     // find out of the word (which byte) 
wire[2:0]   OFFSET_FSM = Addr_FSM[3:1]; // find out of the word (which byte) 
wire[127:0] BLOCK_EN;                   // convert the set to one hot
wire[127:0] BLOCK_EN_STALLED;           // stall from last cycle
wire[127:0] WORD_SEL;                   // convert the offset to one hot
wire[127:0] WORD_SEL_FSM;               // convert the offset to one hot
shifter_6 shifter_1(.shift_out(BLOCK_EN), .shift_val(SET));                       // findout the block 
shifter_6 shifter_s(.shift_out(BLOCK_EN_STALLED), .shift_val(SET_STALLED)); // findout the block 
shifter_6 shifter_2(.shift_out(WORD_SEL), .shift_val({{3'b0},{OFFSET}}));         // findout the word 
shifter_6 shifter_3(.shift_out(WORD_SEL_FSM), .shift_val({{3'b0},{OFFSET_FSM}})); // findout the word 

assign Right_M_BE = Right_M_WE_OUT?BLOCK_EN_STALLED:BLOCK_EN;   // if write to metadata, need update both!
assign Left_M_BE  = Left_M_WE_OUT ?BLOCK_EN_STALLED:BLOCK_EN;   // if write to metadata, need update both!
assign Right_D_BE = BLOCK_EN;           // if write to metadata, need update both!
assign Left_D_BE  = BLOCK_EN;           // if write to metadata, need update both!
// Metadata wires
wire        Left_VLD;                   // Metadata read from left way                  
wire        Left_LRU; 
wire[6:0]   Left_TAG_RD;

wire        Right_VLD;                  // Metadata read from right way
wire        Right_LRU; 
wire[6:0]   Right_TAG_RD;

//////////////////////////////////////////
// Metadata format:
// bit 0-5: Tag
// bit 6  : vld
// bit 7  : LRU
//////////////////////////////////////////
assign Left_LRU =    Left_M_OUT[7];         // get curr metadata from left way
assign Left_VLD =    Left_M_OUT[6];
assign Left_TAG_RD = Left_M_OUT[5:0];       

assign Right_LRU =    Right_M_OUT[7];       // get curr metadata from right way
assign Right_VLD =    Right_M_OUT[6];
assign Right_TAG_RD = Right_M_OUT[5:0];

// Check if hit.
wire Hit_Left;
wire Hit_Right; 
assign Hit_Left  = Left_M_WE_OUT?  1'b0:((TAG == Left_TAG_RD )&(Left_VLD));
assign Hit_Right = Right_M_WE_OUT? 1'b0:((TAG == Right_TAG_RD)&(Right_VLD));
assign Miss = (!(Hit_Left|Hit_Right));        // miss if:
                                                    // there is an read/write operation and
                                                    // not found in cache.
wire   Hit;
assign Hit = (R)&(Hit_Left|Hit_Right);

// Data write logic
wire   GoLeft;                                                      // Replace the left block.
assign GoLeft       = !Left_LRU;                                    // if left is not recently used, or is empty, replace left.
assign Left_D_IN    = DataIn_FSM;             // get the data to write from FSM on miss.
assign Right_D_IN   = DataIn_FSM;             // get the data to write from cpu on hit.
assign Left_D_WORD  = Hit_Left?  WORD_SEL[7:0]:WORD_SEL_FSM[7:0];   // decide which word write into.
assign Right_D_WORD = Hit_Right? WORD_SEL[7:0]:WORD_SEL_FSM[7:0];   // if hit, use cpu offset. else, use fsm offset.
assign Left_D_WE    = (Data_WE)? GoLeft:1'b0;       // write to the cache when:
assign Right_D_WE   = (Data_WE)?!GoLeft:1'b0;       // Cache write hit, or fsm require write

// Metadata write logic
assign Left_M_WE_IN    = (Left_M_IN  ==  Left_M_OUT)?1'b0:MetaData_WE|Hit;                              // always update both metadata if needed
assign Right_M_WE_IN   = (Right_M_IN == Right_M_OUT)?1'b0:MetaData_WE|Hit;                              // update if FSM ask so or on cache hit.
assign Left_M_IN    = Hit_Left? {{2'h3},{TAG[5:0]}}:                // hit left? update the VLD and LRU!
                      (GoLeft&!Hit_Right)?   {{2'h3},{TAG[5:0]}}:   // miss but replace left? update TAG,VLD and LRU!;
                      {{1'b0},{Left_M_OUT[6:0]}};                   // miss but replace the right, or hit right? change LRU to 0!;
assign Right_M_IN   = Hit_Right? {{2'h3},{TAG[5:0]}}:               // hit right? update the VLD and LRU!
                      (!GoLeft&!Hit_Left)?   {{2'h3},{TAG[5:0]}}:   // miss but replace right? update TAG,VLD and LRU!;
                      {{1'b0},{Right_M_OUT[6:0]}};                   // miss but replace the left, or hit left? change LRU to 0!;

// Metadata write logic
wire temp0;
wire temp1;
assign temp0 =stall_I?1'b0:Left_M_WE_IN;
assign temp1 = stall_I?1'b0:Right_M_WE_IN;
Register_1 Left_ME_REG(.Q(Left_M_WE_OUT), .D(temp0), .clk(clk), .rst(rst), .wrtEn(1'b1));
Register_1 Right_ME_REG(.Q(Right_M_WE_OUT), .D(temp1), .clk(clk), .rst(rst), .wrtEn(1'b1));
Register_16 META_REG(.Q({{Left_M_REG_OUT},{Right_M_REG_OUT}}), .D({{Left_M_IN},{Right_M_IN}}), .clk(clk), 
.rst(rst), .wrtEn(1'b1));
wire [15:0] temp2;
assign temp2 = {{10'h0},{SET}};
Register_16 META_BE_REG(.Q({{10'h0},{SET_STALLED}}), .D(temp2), .clk(clk), 
.rst(rst), .wrtEn(1'b1));

assign stall_I = (Left_M_WE_IN&Hit_Left)|(Right_M_WE_IN&Hit_Right);       // if one side both hit and


assign DataOut_CPU = Hit_Left?Left_D_OUT:
                     Hit_Right?Right_D_OUT:
                     GoLeft?Left_D_OUT:
                     Right_D_OUT;                         
endmodule