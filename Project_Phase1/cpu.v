module cpu(clk, rst_n, hlt, pc);
// TODO: change initial load image in both memory.
input clk, rst_n;
output hlt;
output [15:0]pc;

wire[3:0] OPOCODE;//opocode
// memory system
wire[15:0]PC_IN,PC_OUT,DATA_IN,DATA_OUT,PC_ADDR,DATA_ADDR;

wire PC_WE,PC_RD,DATA_WE,DATA_RD;       // write enable when WE and RD are both high
assign PC_RD = 1'b1;
assign PC_WE = 1'b0;
assign pc = PC_OUT;
assign DATA_WE = DATA_RD&OPOCODE[0];
assign DATA_RD = OPOCODE[3]&!OPOCODE[2]&!OPOCODE[1];
memory_I InstructionMem (.data_out(PC_OUT), .data_in(PC_IN), .addr(PC_ADDR), .enable(PC_RD), .wr(PC_WE), .clk(clk), .rst(!rst_n));
memory_D DataMed        (.data_out(DATA_OUT), .data_in(DATA_IN), .addr(DATA_ADDR), .enable(DATA_RD), .wr(DATA_WE), .clk(clk), .rst(!rst_n));
endmodule
