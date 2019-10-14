module decoder(instruction, opcode, rs, rt, rd, immediate_8bit, offset_4bit, 
                offset_9bit, condition, , writem_en, writer_en, halt);

////////////register in rd, rs, rt sequence////////////////

input [15:0] instruction;
output [3:0] rs, rt, rd, opcode, offset_4bit;
assign [2:0] condition;
output [7:0] immediate_8bit;
output [8:0] offset_9bit;
output halt, writem_en, writer_en;

assign writem_en = (opcode == 4'b1001);
assign writer_en = !((opcode == 4'1001) || (opcode[3] & opcode[2]));
assign opcode = instruction[15:12];
assign halt = (opcode == 4'b1111);
assign rd = instruction[11:8];
assign rs = (opcode[3]&(!opcode[2]) ? instruction[7 :4] : instruction[7:4];
assign rt = (opcode[3]&(!opcode[2]) ? instruction[11:8] : instruction[3:0];
assign offset_4bit = instruction[3:0];
assign immediate_8bit = instruction[7:0];
assign offset_9bit = (opcode == 4'b1100)? instruction[8:0] : 8'h00;
assign condition = instruction[11:9];


endmodule