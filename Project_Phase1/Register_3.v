module Register_3.v(Q,D,clk,rst,WriteEnableN,WriteEnableZ,WriteEnableV);
input[2:0] Q;
output[2:0] D;
input clk,rst,WriteEnableN,WriteEnableZ,WriteEnableV;
dff DFFN(.q(Q[0]), .d(D[0]), .wen(WriteEnableN), .clk(clk), .rst(rst));
dff DFFZ(.q(Q[1]), .d(D[1]), .wen(WriteEnableZ), .clk(clk), .rst(rst));
dff DFFV(.q(Q[2]), .d(D[2]), .wen(WriteEnableV), .clk(clk), .rst(rst));

endmodule