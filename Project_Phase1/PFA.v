module PFA(input a, input b, input cin, output s, output g, output p);

assign g = a & b;
assign p = a ^ b;
assign s = cin ^ p;

endmodule