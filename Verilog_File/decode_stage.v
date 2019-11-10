module decode_stage(register_input, WB, M , EX, , data_out1, data_out2, next_i, rs, rt1, rt2, rd,opcode
                        sign_extend);

/////////////////from/to IF/ID register
input [15:0] register_input, next_i;

/////////////////to ID/EX register
output [15:0] data_out1, data_out2, sign_extend;
output [2:0] WB, M, EX;
output [3:0] rs, rt1, rt2, rd, opcode;


decoder decoder(.instruction(PC_OUT), .opcode(OPOCODE), .rs(rs), .rt(rt), .rd(rd), 
.immediate_8bit(I), .offset_9bit(offset_9bit), .condition(CONDITION), .writem_en(writem_en), .writer_en(writer_en), .halt(hlt));

// register file
RegisterFile regfile(.clk(clk), .rst(!rst_n), .SrcReg1(rs), .SrcReg2(rt), 
                    .DstReg(rd), .WriteReg(writer_en), .DstData(REG_DATA), 
                    .SrcData1(A), .SrcData2(B));





endmodule