module cpu(clk, rst_n, hlt, pc);
// TODO: change initial load image in both memory.
input clk, rst_n;
output hlt;
output [15:0]pc;

wire[3:0] OPOCODE;//opocode

// Processing Unit
wire[15:0] A,B,RES;
wire[7:0] I;
ALU alu (.A(A),.B(B),.I(I),.RES(RES),.opocode(OPOCODE));

// memory system
wire[15:0]PC_IN,PC_OUT,DATA_IN,DATA_OUT,PC_ADDR,DATA_ADDR;

wire PC_WE,PC_RD,DATA_WE,DATA_RD;       // write enable when WE and RD are both high
assign PC_RD = 1'b1;
assign PC_WE = 1'b0;
assign pc = PC_OUT;
assign DATA_RD = OPOCODE[3]&!OPOCODE[2]&!OPOCODE[1];
assign DATA_IN = B;
assign DATA_ADDR = RES;

memory_I InstructionMem (.data_out(PC_OUT), .data_in(PC_IN), .addr(PC_ADDR), .enable(PC_RD), .wr(PC_WE), .clk(clk), .rst(!rst_n));
memory_D DataMed        (.data_out(DATA_OUT), .data_in(DATA_IN), .addr(DATA_ADDR), .enable(DATA_RD), .wr(DATA_WE), .clk(clk), .rst(!rst_n));

// PC register
wire[2:0] BR;
// decoder
wire[15:0] PC_Reg_OUT;
wire[3:0] rs,rt,rd;
wire writer_en,writem_en,halt;
wire [8:0] offset_9bit;
decoder decoder(.instruction(PC_Reg_OUT), .opcode(OPOCODE), .rs(rs), .rt(rt), .rd(rd), 
.immediate_8bit(I), .offset_9bit(offset_9bit), .condition(BR), .writem_en(writem_en), .writer_en(writer_en), .halt(halt));
// register file
RegisterFile regfile(.clk(clk), .rst(!rst_n), .SrcReg1(rs), .SrcReg2(rt), 
                    .DstReg(rd), .WriteReg(writer_en), .DstData(RES), 
                    .SrcData1(A), .SrcData2(B));

assign DATA_WE = writem_en; // enable memory write
// write back (register, memory) logic

endmodule
