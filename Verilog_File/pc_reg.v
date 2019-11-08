module pc_reg(rst, clk, PC_in, PC_out);

input rst, clk;
input wire [15:0]PC_in;
output wire [15:0]PC_out;

dff bit0(.q(PC_out[0]), .d(PC_in[0]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit1(.q(PC_out[1]), .d(PC_in[1]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit2(.q(PC_out[2]), .d(PC_in[2]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit3(.q(PC_out[3]), .d(PC_in[3]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit4(.q(PC_out[4]), .d(PC_in[4]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit5(.q(PC_out[5]), .d(PC_in[5]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit6(.q(PC_out[6]), .d(PC_in[6]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit7(.q(PC_out[7]), .d(PC_in[7]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit8(.q(PC_out[8]), .d(PC_in[8]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit9(.q(PC_out[9]), .d(PC_in[9]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit10(.q(PC_out[10]), .d(PC_in[10]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit11(.q(PC_out[11]), .d(PC_in[11]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit12(.q(PC_out[12]), .d(PC_in[12]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit13(.q(PC_out[13]), .d(PC_in[13]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit14(.q(PC_out[14]), .d(PC_in[14]), .wen(1'b1), .clk(clk), .rst(rst));
dff bit15(.q(PC_out[15]), .d(PC_in[15]), .wen(1'b1), .clk(clk), .rst(rst));


endmodule