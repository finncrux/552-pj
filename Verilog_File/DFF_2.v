
module dff_2 (Q, D, WE, clk, rst);
    input [1:0] D;
    input WE;
    input clk;
    input rst;
    output [1:0] Q;

    dff DFF[1:0](.q(Q), .d(D), .wen(WE), .clk(clk), .rst(rst));

endmodule
