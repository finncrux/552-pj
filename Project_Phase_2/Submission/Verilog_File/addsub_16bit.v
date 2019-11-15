module addsub_16bit(input[15:0] A, input[15:0] B, input sub, output[15:0] Sum, output Ovfl);

wire g0,g1,g2,g3,p0,p1,p2,p3,c1,c2,c3,Cout,o0,o1,o2,o3;
wire [15:0] B_in, S;
wire co0,co1,co2,co3;

//assign P = p0 & p1 & p2 & p3;
//assign G = g3 | p3&g2 | p3&p2&g1 | p3&p2&p1&g0;
assign c1 = g0 | p0&sub;
assign c2 = g1 | p1&g0 | p1&p0&sub;
assign c3 = g2 | p2&g1 | p2&p1&g0 | p2&p1&p0&sub;
assign Cout = g3 | p3&g2 | p3&p2&g1 | p3&p2&p1&g0 | p3&p2&p1&p0&sub;


assign B_in = sub? ~B : B;

CLA_4bit cla0(.A(A[3:0]), .B(B_in[3:0]), .Cin(sub), .S(S[3:0]), .G(g0), .P(p0), .Ovfl(o0), .Cout(co0));
CLA_4bit cla1(.A(A[7:4]), .B(B_in[7:4]), .Cin(c1), .S(S[7:4]), .G(g1), .P(p1), .Ovfl(o1), .Cout(co1));
CLA_4bit cla2(.A(A[11:8]), .B(B_in[11:8]), .Cin(c2), .S(S[11:8]), .G(g2), .P(p2), .Ovfl(o2), .Cout(co2));
CLA_4bit cla3(.A(A[15:12]), .B(B_in[15:12]), .Cin(c3), .S(S[15:12]), .G(g3), .P(p3), .Ovfl(o3), .Cout(co3));

assign Ovfl = o3;
assign Sum = o3? (S[15] ? 16'h7fff : 16'h8000) : S;


endmodule