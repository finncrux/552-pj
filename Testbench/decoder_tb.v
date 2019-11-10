module decoder_tb();

reg [15:0]instruction;
wire [3:0] rs, rt, rd, opcode, offset_4bit;
wire [2:0] condition;
wire [7:0] immediate_8bit;
wire [8:0] offset_9bit;
wire halt, writem_en, writer_en;
reg [3:0]op;

decoder iDUT(.instruction(instruction), .opcode(opcode), .rs(rs), .rt(rt), .rd(rd), .immediate_8bit(immediate_8bit)
                , .offset_4bit(offset_4bit), .offset_9bit(offset_9bit), .condition(condition),
                 .writem_en(writem_en), .writer_en(writer_en), .halt(halt));

initial begin
    op = 4'b0000;
    repeat(16) begin
    
    instruction = {op, 12'b101100111000};
    #5;
    op = op + 1'b1; 
    end
end

endmodule