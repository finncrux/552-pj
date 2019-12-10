//untested
module Register_16(Q, D, clk, rst, wrtEn);

input[15:0] Q;
output[15:0] D;
input clk, rst, wrtEn;

dff DFF0(.q(Q[0]), .d(D[0]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF1(.q(Q[1]), .d(D[1]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF2(.q(Q[2]), .d(D[2]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF3(.q(Q[3]), .d(D[3]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF4(.q(Q[4]), .d(D[4]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF5(.q(Q[5]), .d(D[5]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF6(.q(Q[6]), .d(D[6]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF7(.q(Q[7]), .d(D[7]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF8(.q(Q[8]), .d(D[8]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF9(.q(Q[9]), .d(D[9]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF10(.q(Q[10]), .d(D[10]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF11(.q(Q[11]), .d(D[11]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF12(.q(Q[12]), .d(D[12]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF13(.q(Q[13]), .d(D[13]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF14(.q(Q[14]), .d(D[14]), .wen(wrtEn), .clk(clk), .rst(rst));
dff DFF15(.q(Q[15]), .d(D[15]), .wen(wrtEn), .clk(clk), .rst(rst));

endmodule