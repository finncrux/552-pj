module cpu(clk, rst_n, hlt, pc);

input clk, rst_n;
output hlt;
output [15:0]pc;

// memory system
wire[15:0]PC_IN,PC_OUT,DATA_IN,DATA_OUT,PC_ADDR,DATA_ADDR;
wire PC_WE,DATA_WE,PC_RD,DATA_RD;       // write enable when WE and RD are both high
memory_I InstructionMem (.data_out(PC_OUT), .data_in(PC_IN), .addr(PC_ADDR), .enable(PC_RD), .wr(PC_WE), .clk(clk), .rst(!rst_n));
memory_D DataMem (.data_out(DATA_OUT), .data_in(DATA_IN), .addr(DATA_ADDR), .enable(DATA_RD), .wr(DATA_WE), .clk(clk), .rst(!rst_n));
endmodule
