module shifter_tb();

reg [3:0] opcode, shift_val;
reg signed [15:0] shift_in;
wire signed[15:0] shift_out;

wire [15:0] res1, res2, res3;

shifter iDUT(.opcode(opcode), .shift_in(shift_in), .shift_out(shift_out), 
            .shift_val(shift_val));

assign res1 = shift_out - (shift_in << shift_val);
assign res2 = shift_out - (shift_in >>> shift_val);
assign res3 = shift_in >>> shift_val;
initial begin
    opcode = 4'b0100; ////SLL
    repeat (30) begin
        shift_in = $random % 16'hffff;
        shift_val = $random % 4'hf;
        #5;
    end

    opcode = 4'b0101; ////SRA
    repeat (30) begin
        shift_in = $random % 16'hffff;
        shift_val = $random % 4'hf;
        #5;
    end

    opcode = 4'b0110; ////ROR
    repeat (30) begin
        shift_in = $random % 16'hffff;
        shift_val = $random % 4'hf;
        #5;
    end
end

endmodule
