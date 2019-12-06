module Cache_Ctrl(DataIn_I, DataOut_I, DataArray_WE_I, MetaDataArray_WE_I, Miss_I, Addr_I, IF
                    DataIn_D, DataOut_D, DataArray_WE_D, MetaDataArray_WE_D, Miss_D, Addr_D, R, W, 
                    DataIn_M, DataOut_M, DataVLD, Addr_M, WE_M, clk, rst)

//////////////////////////////////////////
// Ports
//////////////////////////////////////////
input   [15:0]  DataIn_I;
input   [15:0]  Addr_I;
input           Miss_I;
input           IF;
output  [15:0]  DataOut_I;
output          DataArray_WE_I;
output          MetaDataArray_WE_I;

input   [15:0]  DataIn_D;
input   [15:0]  Addr_D;
input           Miss_D;
input           R, W;
output  [15:0]  DataOut_D;
output          DataArray_WE_D;
output          MetaDataArray_WE_D;

input   [15:0]  DataIn_M;
input           DataVLD;
output  [15:0]  DataOut_M;
output  [15:0]  Addr_M
output          WE_M;

input clk, rst;


//////////////////////////////////////////
// Cntr
//////////////////////////////////////////

// External Wire

// Internal Wire
reg cycle_enable;
reg[3:0] counter_cycle_wire, counter_block_wire;
wire ovfl11, ovfl22, s11, s22, g11, g22, p11, p22;
wire[3:0] counter_block, counter_block1;

Register_4 counter_register(.Q(counter_block1), .D(counter_block), .clk(clk), .rst(!rst_n | block_clear), .wrtEn(1'b1));
CLA_4bit counter_adder(.A(block_clear? 4'b0000 : counter_block1), .B(4'b0000), 
                        .Cin(1'b1 & ready_block & (counter_block1 != 4'b0111)), 
                        .S(counter_block), .G(), .P(), .Ovfl(), .Cout());




//////////////////////////////////////////
// FSM
//////////////////////////////////////////

// Params
localparam IDLE   = 3'b000;
localparam CHK_I  = 3'b001;
localparam WAIT_I = 3'b010;
localparam TAG_I  = 3'b011;
localparam CHK_D  = 3'b100;
localparam WAIT_D = 3'b101;
localparam WRT_D  = 3'b110;
localparam TAG_D  = 3'b111;

// Next State Flop
wire state, nxt_state;
reg nxt_state_reg;
assign nxt_state = nxt_state_reg;
dff_3 FSM_state(.D(nxt_state), .Q(state), .WE(1'b1), .clk(clk), .rst(rst));

// Next State Combination Logic
always@(*) begin
    
    case(state)
        IDLE: begin //IDLE

        end
        CHK_I:  begin

        end
        WAIT_I: begin

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