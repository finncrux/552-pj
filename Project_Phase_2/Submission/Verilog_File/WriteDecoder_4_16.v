module WriteDecoder_4_16(input[3:0] RegId, input WriteReg, output[15:0] Wordline);

wire [15:0] wordline_in, wordline_out, wordline_in0, wordline_in1, wordline_in2;

assign Wordline = WriteReg ? wordline_out : 16'h0000;

//shift the 1 if needed
assign wordline_in = 16'h0001;
assign wordline_in0 = RegId[0] ? (wordline_in << 1) : wordline_in;
assign wordline_in1 = RegId[1] ? (wordline_in0 << 2) : wordline_in0;
assign wordline_in2 = RegId[2] ? (wordline_in1 << 4) : wordline_in1;
assign wordline_out = RegId[3] ? (wordline_in2 << 8) : wordline_in2;

endmodule