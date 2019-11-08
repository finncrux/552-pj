module WriteDecoder_4_16(input [3:0] RegId, input WriteReg, output [15:0] Wordline);
wire[15:0] ShiftResult;
Shifter shft(.Shift_Out(ShiftResult), .Shift_In(16'h0001), .Shift_Val(RegId), .Mode(1'b0));
assign Wordline = WriteReg?ShiftResult:16'h0000;
endmodule
