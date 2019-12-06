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


//////////////////////////////////////////
// address computation
//////////////////////////////////////////
wire [15:0]     start_addr; 
//////////base address
wire [15:0]     address_in, address_out, address_store;
//////////address need to be stored, new computed address, address currently stored
wire            ovfl;
reg             add_address_begin, add_address_ready;
//////////signal from FSM:ready to start adding address, ready to next address

assign start_addr = {miss_address[15:4],{4{1'b0}}};
assign address_in = add_address_begin? 
                    start_addr : add_address_ready? address_out : address_store;
addsub_16bit adder(.A(address_store), .B(16'h2), .sub(1'b0), .Sum(address_out), .Ovfl(ovfl));
Register_16 storeAddr(.Q(address_store), .D(address_in), .clk(clk), .rst(!rst_n), .wrtEn((counter_block1 !== 4'b0111)));
assign memory_address = address_store;

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

// counter for states
addsub_4bit state_counter(.Sum(nxt_state), .Ovfl( ), .A(state), .B({{3{1'b0}},nxt_state_ready_wire}), .sub(1'b0));

// Next State Flop
wire [2:0] state, nxt_state;
wire       nxt_state_ready_wire;
reg        nxt_state_ready;      //// =1 when is ready to go to next state
assign     nxt_state_ready_wire = nxt_state_ready;
dff_3 FSM_state(.D(nxt_state), .Q(state), WE(1'b1), .clk(clk), .rst(!rst | (!R & !W & !IF)));

// Next State Combination Logic
always@(*) begin
    
    case(state)
        IDLE: begin //IDLE
            nxt_state_ready = W | R | IF;
            Stall = 1'b1;
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