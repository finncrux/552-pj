module cache_fill_FSM(clk, rst_n, miss_detected, miss_address, fsm_busy, write_data_array, write_tag_array,memory_address, memory_data, memory_data_valid);

input clk, rst_n;
input miss_detected; // active high when tag match logic detects a miss
input [15:0] miss_address; // address that missed the cache
output fsm_busy; // asserted while FSM is busy handling the miss (can be used as pipeline stall signal)
output write_data_array; // write enable to cache data array to signal when filling with memory_data
output write_tag_array; // write enable to cache tag array to signal when all words are filled in to data array
output [15:0] memory_address; // address to read from memory
input [15:0] memory_data; // data returned by memory (afterdelay)
input memory_data_valid; // active high indicates valid data returning on memory bus

localparam idle = 1'b0;
localparam Wait = 1'b1;

wire [15:0] start_addr;

assign start_addr = {miss_address[15:4],{4{1'b0}}};

wire Nstate1,State;
reg Nstate;  //current state and next state

assign Nstate1 = Nstate;
dff StateMachine(.q(State), .d(Nstate1), .wen(1'b1), .clk(clk), .rst(!rst_n));

reg ready_cycle, ready_block;
reg cycle_clear, block_clear;



/////////////////////////counter for cycles and blocks
reg cycle_enable;
reg[3:0] counter_cycle_wire, counter_block_wire;
wire ovfl11, ovfl22, s11, s22, g11, g22, p11, p22;
wire[3:0] counter_cycle, counter_block, counter_block1, counter_cycle1;

Register_4 current_cycle(.Q(counter_cycle1), .D(counter_cycle), .clk(clk), .rst(!rst_n | cycle_clear), .wrtEn(cycle_enable));
Register_4 current_block(.Q(counter_block1), .D(counter_block), .clk(clk), .rst(!rst_n | block_clear), .wrtEn(1'b1));
CLA_4bit cycles4(.A(cycle_clear? 4'b0000 : counter_cycle1), .B(4'b0000), .Cin(1'b1 & ready_cycle & (counter_cycle1 != 4'b0100)), .S(counter_cycle), .G(g11), .P(p11), .Ovfl(ovfl11), .Cout(s22));
CLA_4bit blocks8(.A(block_clear? 4'b0000 : counter_block1), .B(4'b0000), .Cin(1'b1 & ready_block & (counter_block1 != 4'b0111)), .S(counter_block), .G(g22), .P(p22), .Ovfl(ovfl22), .Cout(s11));

wire back_to_idle;
assign back_to_idle = (counter_block1 == 4'b0111);
reg fsm_busy1, write_data_array1, write_tag_array1;
assign fsm_busy = fsm_busy1;
assign write_data_array = write_data_array1;
assign write_tag_array = write_tag_array1;


/////////////////////////address update
wire [15:0] address_in, address_out, address_store;
wire ovfl;
reg add_address_begin, add_address_ready;
assign address_in = add_address_begin? 
                    start_addr : add_address_ready? address_out : address_store;
addsub_16bit adder(.A(address_store), .B(16'h2), .sub(1'b0), .Sum(address_out), .Ovfl(ovfl));
Register_16 storeAddr(.Q(address_store), .D(address_in), .clk(clk), .rst(!rst_n), .wrtEn((counter_block1 !== 4'b0111)));
assign memory_address = address_store;

always@(*) begin

    case(State)
        Wait:   begin   /////when state is wait
            fsm_busy1 = 1'b1;
            Nstate = ~back_to_idle;
            write_tag_array1 = back_to_idle;
            write_data_array1 = (counter_cycle1 == 4'b0100);
            cycle_enable = !(counter_cycle1 == 4'b0100);
            ready_cycle = 1'b1;
            ready_block = counter_cycle1 == 4'b0100;
            cycle_clear = counter_cycle1 == 4'b0100 & counter_block1 == 4'b0111;
            block_clear = counter_block1 == 4'b1000;
            add_address_begin = counter_block == 4'b0000;
            add_address_ready = ready_block & memory_data_valid;
        end
        default:   begin   /////when state is idle
            fsm_busy1 = miss_detected;
            cycle_enable = 1'b0;
            Nstate = miss_detected;
            write_data_array1 = 1'b0;
            write_tag_array1 = 1'b0;
            cycle_clear = !miss_detected;
            block_clear = !miss_detected; 
            ready_cycle = miss_detected;
            ready_block = 1'b0;
            add_address_begin = miss_detected;
            add_address_ready = 1'b0;

        end
    endcase
            
end

endmodule