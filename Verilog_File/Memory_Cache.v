module Memory_Cache(clk,rst_n,Write,Read,DataIn,DataOut,Stall,Addr);
input       clk,rst_n;
input       Write;
input       Read;
input[15:0] Addr;
input[7:0]  DataIn;
output[7:0] DataOut;
output      Stall;

wire        rst;
wire        fsm_busy;
wire        miss_detected;
wire        write_data_array;
wire        write_tag_array;
wire        memory_data_valid;
wire[15:0]  miss_address;
wire[15:0]  memory_address;
wire[15:0]  memory_data;
assign rst = !rst_n;

////////////////////////////////////////
// MetaDataArray and wires
////////////////////////////////////////
wire MetaDataArray_WR;          // write enable for metadata
wire[7:0]   MetaDataArray_IN;   // write value to metadata
wire[7:0]   MetadataArray_OUT;  // read avlue from metadata
wire[127:0] MetaDataArray_EN;   // onehot, which block to be read or write

MetaDataArray Metadata1(.clk(clk), .rst(rst_n), .DataIn(MetaDataArray_IN), .Write(MetaDataArray_WR),
 .BlockEnable(MetaDataArray_EN), .DataOut(MetadataArray_OUT));

////////////////////////////////////////
// DataArray and wires
////////////////////////////////////////
wire        DataArray_WR;      // enable for w
wire[15:0]  DataArray_IN;      // data input
wire[15:0]  DataArray_OUT;     // data read out
wire[127:0] DataArray_EN;      // enable for r/w. one hot
wire[7:0]   DataArray_ADDR;    // 128 block address available in total
DataArray Data(.clk(clk), .rst(rst_n), .DataIn(DataArray_IN), 
.Write(DataArray_WR), .BlockEnable(DataArray_EN), .WordEnable(DataArray_ADDR), .DataOut(DataArray_OUT));

/////////////////////////////////////////
// Multicycle Memroy
/////////////////////////////////////////
wire        Memory_WR;
wire        Memory_EN;
wire        Memroy_VLD;
wire[15:0]  Memory_IN;
wire[15:0]  Memory_OUT;
wire[15:0]  Memroy_ADDR;

memory4c Memory (.data_out(Memory_OUT), .data_in(Memory_IN), .addr(Memroy_ADDR), 
.enable(Memory_EN), .wr(Memory_WR), .clk(clk), .rst(rst_n), .data_valid(Memroy_VLD));

//////////////////////////////////////////
// CLOCK
// Expected Behaviour
//
// CLK_RESET    0   1   0   0   0   0   ...
//              
// CLK_OUT      x   0   1   2   3   4   ...
//////////////////////////////////////////
wire       CLK_RESET;  // use this 
wire [3:0] CLK_OUT;    // use this
wire [3:0] CLK_RES;    // not this
wire [3:0] CLK_A,CLK_B;
wire [3:0] CLK_REG_IN;
wire ovfl;
wire G,P,Cout;
assign CLK_RESET = CLK_RESET_DEBUG;
assign CLK_REG_IN = CLK_RESET?4'h0:CLK_RES;
assign CLK_B = CLK_RESET?4'b0:4'b1;
assign CLK_A = CLK_RESET?4'b0:CLK_OUT;

CLA_4bit CLOCK(.A(CLK_A), .B(CLK_B), .Cin(1'b0), .S(CLK_RES), .G(G), .P(P), .Ovfl(ovfl), .Cout(Cout));
Register_4 CLOCK_RES(.D(CLK_REG_IN), .Q(CLK_OUT), .clk(clk), .rst(!rst_n), .wrtEn(1'b1));

//////////////////////////////////////////
// FSM
//////////////////////////////////////////



// Next State Flop
wire state, nxt_state;
reg nxt_state_reg;
assign nxt_state = nxt_state_reg;
dff_3 FSM_state(.D(), .Q, WE, clk, rst);

// Next State Combination Logic
always@(*) begin
    
    case(state)
        IDLE: begin //IDLE

        end
        CHK_I:  begin

        end
        WAIT_I: begin

        end
        WRT_I:  begin

        end
        TAG_I:  begin

        end
        CHK_D:  begin

        end
        WAIT_D: begin

        end
        WRT_D:  begin

        end
        TAG_D:  begin

        end

    endcase

end

endmodule