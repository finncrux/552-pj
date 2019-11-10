module decode_stage(register_input, data_out1_ID, data_out2_ID, next_i, rs, rt, rd,OPCODE,
                        sign_extend_ID, REG_DATA, MemToReg_ID, MEM_DATA_RD_EN_ID, rst_n, clk, 
                        F, next_instruction, writeReg_en_ID, writeMem_en_ID, writer_en);

/////////////////from/to IF/ID register
input [15:0] register_input, next_i;

/////////////////to ID/EX register
output [15:0] data_out1_ID, data_out2_ID, sign_extend_ID;
output writeReg_en_ID, writeMem_en_ID, MEM_DATA_RD_EN_ID;
output MemToReg_ID;  /////////////// load -> 0, other -> 1
output [3:0] rs, rt, rd, OPCODE;

////////////////inside signal
input [15:0] REG_DATA;
input rst_n, clk;
input writer_en;
input [3:0]F;
output next_instruction;

wire Stall, writeReg1_en_ID, writeMem1_en_ID, MEM_DATA_RD_EN1_ID;
wire [3:0]OPCODE1;
wire taken;
wire [2:0]C;
wire [15:0]PC_B, PC_BR;
wire ovfl, ovfl1;
wire [7:0]I;
assign Taken = (C[2:0]==3'b000)?!F[2]:
               (C[2:0]==3'b001)?F[2]:
               (C[2:0]==3'b010)?(!F[2]&(!F[0])):
               (C[2:0]==3'b011)?F[0]:
               (C[2:0]==3'b100)?(F[2]|(!F[0]&(!F[2]))):
               (C[2:0]==3'b101)?((F[0]|(F[2]))):
               (C[2:0]==3'b110)?(F[1]):
               1'b1;
assign MemToReg_ID = !(OPCODE1 == 4'b1000);
assign sign_extend_ID = {{8{I[7]}}, I};
assign MEM_DATA_RD_EN_ID = OPCODE1[3]&!OPCODE1[2]&!OPCODE1[1];
assign writeReg_en_ID = Stall? 1'b0 : writeReg1_en_ID;
assign writeMem_en_ID = Stall? 1'b0 : writeMem1_en_ID;
assign MEM_DATA_RD_EN_ID = Stall? 1'b0 : MEM_DATA_RD_EN1_ID;
assign OPOCODE = Stall? 1'b0 : OPCODE1;
assign PC_BR = data_out1_ID;
assign next_instruction = taken? (OPCODE1[0]? PC_B : PC_BR) : next_i;

adder_B addsub_16bit(.A(next_i), .B(offset_9bit), .sub(1'b0), .Sum(PC_B), .Ovfl(ovfl1));
decoder decoder(.instruction(register_input), .opcode(OPCODE1), .rs(rs), .rt(rt), .rd(rd), 
                .immediate_8bit(I), .offset_9bit(offset_9bit), .condition(C), .writem_en(writeMem1_en_ID),
                .writer_en(writeReg1_en_ID), .halt(hlt));

// register file
RegisterFile regfile(.clk(clk), .rst(!rst_n), .SrcReg1(rs), .SrcReg2(rt), .DstReg(rd), .WriteReg( writer_en), .DstData(REG_DATA), 
                    .SrcData1(data_out1_ID), .SrcData2(data_out2_ID));


endmodule