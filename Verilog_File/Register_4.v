//untested
module Register_4(Q, D, clk, rst, wrtEn);

input[3:0] D;
output[3:0] Q;
input clk, rst, wrtEn;

dff DFF0(.q(Q[0]), .d(D[0]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF1(.q(Q[1]), .d(D[1]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF2(.q(Q[2]), .d(D[2]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF3(.q(Q[3]), .d(D[3]), .wen(wrtEn), .clk(clk), .rst(rst));

endmodule