module BitCell( input clk,  input rst, input D, input WriteEnable, input ReadEnable1, input ReadEnable2, inout Bitline1, inout Bitline2);
wire Q,Qout;
dff DFF(.q(Q), .d(D), .wen(WriteEnable), .clk(clk), .rst(rst));
assign Qout = WriteEnable?D:Q;
bufif1 buf1(Bitline1,Qout,ReadEnable1);
bufif1 buf2(Bitline2,Qout,ReadEnable2);
endmodule
