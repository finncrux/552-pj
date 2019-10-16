module RED(A,B,SUM);

///////////////////////
/////tested
///////////////////////

input [15:0] A,B;
output [15:0] SUM;
wire [7:0] Sum0,Sum1;
wire c0,c1,c2,c3,c4,c5,c6;
wire o0,o1,o2,o3,o4,o5,o6;
wire g0,g1,g2,g3,g4,g5,g6;
wire p0,p1,p2,p3,p4,p5,p6;
wire[2:0] SUM6;
CLA_4bit CLA0(.A(A[3:0]),.B(B[3:0]),.S(Sum0[3:0]),.Cin(1'b0),.Ovfl(o0),.G(g0),.P(p0), .Cout(c0));
CLA_4bit CLA1(.A(A[7:4]),.B(B[7:4]),.S(Sum0[7:4]),.Cin(c0),.Ovfl(o1),.G(g1),.P(p1), .Cout(c1));

CLA_4bit CLA2(.A(A[11:8]),.B(B[11:8]),.S(Sum1[3:0]),.Cin(1'b0),.Ovfl(o2),.G(g2),.P(p2), .Cout(c2));
CLA_4bit CLA3(.A(A[15:12]),.B(B[15:12]),.S(Sum1[7:4]),.Cin(c2),.Ovfl(o3),.G(g3),.P(p3), .Cout(c3));

CLA_4bit CLA4(.A(Sum0[3:0]),.B(Sum1[3:0]),.S(SUM[3:0]),.Cin(1'b0),.Ovfl(o4),.G(g4),.P(p4), .Cout(c4));
CLA_4bit CLA5(.A(Sum0[7:4]),.B(Sum1[7:4]),.S(SUM[7:4]),.Cin(c4),.Ovfl(o5),.G(g5),.P(p5), .Cout(c5));
CLA_4bit CLA6(.A({3'b000,c1}),.B({3'b000,c3}),.S(SUM[11:8]),.Cin(c5),.Ovfl(o6),.G(g6),.P(p6), .Cout(c6));
assign SUM[15:12] = {4{SUM[11]}};

endmodule