//untested
module Register_1(Q, D, clk, rst, wrtEn);

input D;
output Q;
input clk, rst, wrtEn;

dff DFF(.q(Q), .d(D), .wen(wrtEn), .clk(clk), .rst(rst));

endmodule