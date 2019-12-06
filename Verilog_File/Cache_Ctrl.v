module Cache_Ctrl(DataIn_I, DataOut_I, DataArray_WE_I, MetaDataArray_WE_I, Miss_I, Addr_I, IF
                    DataIn_D, DataOut_D, DataArray_WE_D, MetaDataArray_WE_D, Miss_D, Addr_D, R, W, 
                    DataIn_M, DataOut_M, DataVLD, Addr_M, WE_M, EN_M, clk, rst, Stall)

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
output          EN_M;

input clk, rst;
output Stall;

reg             Stall_fsm;
assign Stall =  Stall_fsm;
//////////////////////////////////////////
// Cntr
//////////////////////////////////////////

// External Wire
wire cntr_full, cntr_rst, cntr_stop;

// Internal Wire
wire[3:0]   cnt, cnt_after;
assign cntr_full = cnt_after == 4'b0111;

Register_4 current_block(.Q(cnt), .D(cnt_after), .clk(clk), .rst(!rst_n | cntr_rst), .wrtEn(1'b1));
CLA_4bit blocks8(.A(cntr_rst? 4'b0000 : cnt), .B(!cntr_stop & !cntr_full), 
                    .Cin(4'b0000), .S(cnt_after), .G( ), .P( ), .Ovfl( ), .Cout( ));


//////////////////////////////////////////
// address computation
//////////////////////////////////////////
wire [15:0]     start_addr; 
//base address
wire [15:0]     address_in, address_out, address_store;
//address need to be stored; new computed address; address currently stored
wire            ovfl;
reg             add_address_begin, add_address_ready;
//////////signal from FSM:ready to start adding address; ready to next address

assign start_addr = {miss_address[15:4],{4{1'b0}}};
assign address_in = add_address_begin? 
                    start_addr : add_address_ready? address_out : address_store;
addsub_16bit adder(.A(address_store), .B(16'h2), .sub(1'b0), .Sum(address_out), .Ovfl(ovfl));
Register_16 storeAddr(.Q(address_store), .D(address_in), .clk(clk), .rst(!rst_n), .wrtEn((counter_block1 !== 4'b0111)));
assign memory_address = address_store;



//////////////////////////////////////////
// FSM
//////////////////////////////////////////

// Params
localparam IDLE   = 2'b00;
localparam WAIT_I = 2'b01;
localparam WAIT_D = 2'b10;

// Next State Flop
wire [1:0] state, nxt_state;
wire       nxt_state_ready_wire, nxt_state_ready_wire_2;
//increment state 1 or 2
reg        nxt_state_ready, nxt_state_ready_2;      //// =1 when is ready to go to next state
// counter for states
wire [3:0] increment_amount;
assign     increment_amount = nxt_state_ready_2? 4'b0010 : nxt_state_ready? 4'b0001 : 4'b0000;
addsub_4bit state_counter(.Sum(nxt_state), .Ovfl( ), .A(state), .B(increment_amount), .sub( ));

assign     nxt_state_ready_wire = nxt_state_ready;
dff_3 FSM_state(.D(nxt_state), .Q(state), WE(1'b1), .clk(clk), .rst(rst));

// Next State Combination Logic
always@(*) begin
    nxt_state_ready = 1'b0;
    nxt_state_ready_2  = 1'b0;
    Stall_fsm = 1'b0;
    block_clear = 1'b1;
    add_address_begin = 1'b0;
    add_address_ready = 1'b0;    
    
    case(state)
        IDLE: begin //IDLE
            nxt_state_ready = Miss_I;
            nxt_state_ready_2 = Miss_D & !Miss_I;
            Stall_fsm = Miss_I | Miss_D;
        end

        WAIT_I: begin
            Stall_fsm = 1'b1;
            nxt_state_ready = Miss_D & counter_block1 == 4'b0111;

        end

        WAIT_D: begin
            Stall_fsm = 1'b1;
        end
    endcase

end

endmodule