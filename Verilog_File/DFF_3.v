
module dff_3 (Q, D, WE, clk, rst);
    input [2:0] D;
    input WE;
    input clk;
    input rst;
    output [2:0] Q;

    dff DFF[2:0](.q(Q), .d(D), .wen(WE), .clk(clk), .rst(rst));

endmodule
