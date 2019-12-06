module Cache_D (clk,rst,DataIn_FSM,DataOut_CPU,Miss,Addr,
MetaData_WE,Data_WE,R,W);
input clk;
input rst;
input R;
input W;
input  [15:0] Addr;
input  [15:0] DataIn_FSM;

input MetaData_WE;
input Data_WE;

wire Left_D_WE;
wire Right_D_WE;
wire Left_M_WE;
wire Right_M_WE;

output [15:0] DataOut_CPU;
output Miss;

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
.BlockEnable(Right_D_BE), .WordEnable(Righr_D_WORD), .DataOut(Right_D_OUT));

// left Metadata
wire[7:0]  Left_M_IN;
wire[7:0]  Left_M_OUT;
wire[127:0]Left_M_BE;
MetaDataArray  Left_M (.clk(clk), .rst(rst), .DataIn(Left_M_IN),  .Write(Left_M_WE), 
.BlockEnable(Left_M_BE), .DataOut(Left_M_OUT));

// right metadata
wire[7:0]  Right_M_IN;
wire[7:0]  Right_M_OUT;
wire[127:0]Right_M_BE;
MetaDataArray  Light_M(.clk(clk), .rst(rst), .DataIn(Right_M_IN), .Write(Right_M_WE), 
.BlockEnable(Right_M_BE), .DataOut(Right_M_OUT));

// Miss Detection
wire[5:0]   SET = Addr[9:4];       // find out which set it is
wire[5:0]   TAG = Addr[15:10];     // find out the tag
wire[2:0]   OFFSET = Addr[3:1];    // offset of the word 
wire[127:0] BLOCK_EN;              // convert to the one hot
wire[127:0] WORD_SEL;              // convert to the one hot
shifter_6 shifter_1(.shift_out(BLOCK_EN), .shift_val(SET)); // findout the block 
shifter_6 shifter_2(.shift_out(WORD_SEL), .shift_val({{3'b0},{OFFSET}})); // findout the block 

assign Right_M_BE = BLOCK_EN;
assign Left_M_BE  = BLOCK_EN;
// Metadata wires
wire        Left_VLD;                  
wire        Left_LRU; 
wire[6:0]   Left_TAG_RD;

wire        Right_VLD;                  
wire        Right_LRU; 
wire[6:0]   Right_TAG_RD;

// Metadata read from memory
assign Left_LRU =    Left_M_OUT[7];
assign Left_VLD =    Left_M_OUT[6];
assign Left_TAG_RD = Left_M_OUT[5:0];

assign Right_LRU =    Right_M_OUT[7];
assign Right_VLD =    Right_M_OUT[6];
assign Right_TAG_RD = Right_M_OUT[5:0];


wire Hit_Left;
wire Hit_Right; 
assign Hit_Left  = ((TAG == Left_TAG_RD )&(Left_VLD));
assign Hit_Right = ((TAG == Right_TAG_RD)&(Right_VLD));
assign Miss = !(Hit_Left|Hit_Right);

// control which data should be written to cache.
wire   GoLeft;      // write to the left block;
assign GoLeft       = !Left_LRU;
assign Left_D_IN    = DataIn_FSM;             // get the data to write from FSM.
assign Right_D_IN   = DataIn_FSM;
assign Left_D_WORD  = WORD_SEL[7:0];          // decide which word write into.
assign Right_D_WORD = WORD_SEL[7:0];
assign Left_D_WE    = Data_WE? GoLeft:1'b0;   // which set should write into?
assign Right_D_WE   = Data_WE?!GoLeft:1'b0;

// Metadata write logic
assign Left_M_WE    = MetaData_WE;           // always update both metadata if needed
assign Right_M_WE   = MetaData_WE;           // always update both meatadata if needed
assign Left_M_IN    = Hit_Left? {{2'h3},{TAG[5:0]}}:   // hit left? update the VLD and LRU!
                      GoLeft?   {{2'h3},{TAG[5:0]}}:   // miss but replace left? update TAG,VLD and LRU!;
                      {{1'b0},{Left_M_OUT[6:0]}};      // miss but replace the right? change LRU to 0!;
assign Right_M_IN   = Hit_Right? {{2'h3},{TAG[5:0]}}:  // hit right? update the VLD and LRU!
                      !GoLeft?   {{2'h3},{TAG[5:0]}}:  // miss but replace right? update TAG,VLD and LRU!;
                      {{1'b0},{Left_M_OUT[6:0]}};      // miss but replace the left? change LRU to 0!;
                       
endmodule