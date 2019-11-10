module decode_stage(register_input, data_out1_ID, data_out2_ID, next_i, rs, rt, rd,opcode
                        sign_extend_ID, writer_en, REG_DATA, MemToReg_ID, DATA_RD, rst_n, clk, writer_en);

/////////////////from/to IF/ID register
input [15:0] register_input, next_i;

/////////////////to ID/EX register
output [15:0] data_out1_ID, data_out2_ID, sign_extend_ID;
output writeReg_en_ID, writeMem_en_ID, MEM_DATA_RD_EN_ID;
output MemToReg_ID;  /////////////// load -> 0, other -> 1
output [3:0] rs, rt, rd, OPOCODE;

////////////////inside signal
input [15:0] REG_DATA;
input rst_n, clk;
input writer_en;

wire Stall, writeReg1_en_ID, writeMem1_en_ID, MEM_DATA_RD_EN1_ID;
wire [3:0]OPCODE1;

assign MemToReg_ID = !(OPOCODE == 4'b1000);
assign sign_extend_ID = {{8{I[7]}}, I};
assign MEM_DATA_RD_EN_ID = OPOCODE[3]&!OPOCODE[2]&!OPOCODE[1];
assign writeReg_en_ID = Stall? 1'b0 : writeReg1_en_ID;
assign writeMem_en_ID = Stall? 1'b0 : writeMem1_en_ID;
assign MEM_DATA_RD_EN_ID = Stall? 1'b0 : MEM_DATA_RD_EN1_ID;
assign OPOCODE = Stall? 1'b0 : OPCODE1;

decoder decoder(.instruction(register_input), .opcode(OPOCODE1), .rs(rs), .rt(rt), .rd(rd), 
                .immediate_8bit(I), .offset_9bit(offset_9bit), .condition(CONDITION), .writem_en(writeMem1_en_ID),
                .writer_en(writeReg1_en_ID), .halt(hlt));

// register file
RegisterFile regfile(.clk(clk), .rst(!rst_n), .SrcReg1(rs), .SrcReg2(rt), .DstReg(rd), .WriteReg( writer_en), .DstData(REG_DATA), 
                    .SrcData1(data_out1_ID), .SrcData2(data_out2_ID));


endmodule