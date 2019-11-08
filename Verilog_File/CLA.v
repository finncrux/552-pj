module CLA_4bit(input[3:0] A, input[3:0] B, input Cin, output[3:0] S, output G, output P, output Ovfl, output Cout);

wire g0,g1,g2,g3,p0,p1,p2,p3,c1,c2,c3;

assign P = p0 & p1 & p2 & p3;
assign G = g3 | p3&g2 | p3&p2&g1 | p3&p2&p1&g0;
assign c1 = g0 | p0&Cin;
assign c2 = g1 | p1&g0 | p1&p0&Cin;
assign c3 = g2 | p2&g1 | p2&p1&g0 | p2&p1&p0&Cin;
assign Cout = g3 | p3&g2 | p3&p2&g1 | p3&p2&p1&g0 | p3&p2&p1&p0&Cin;

assign Ovfl = Cout^c3;

PFA pfa0(.a(A[0]), .b(B[0]), .cin(Cin), .s(S[0]), .g(g0), .p(p0));
PFA pfa1(.a(A[1]), .b(B[1]), .cin(c1), .s(S[1]), .g(g1), .p(p1));
PFA pfa2(.a(A[2]), .b(B[2]), .cin(c2), .s(S[2]), .g(g2), .p(p2));
PFA pfa3(.a(A[3]), .b(B[3]), .cin(c3), .s(S[3]), .g(g3), .p(p3));

endmodule