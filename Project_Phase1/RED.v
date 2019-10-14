module RED(A,B,SUM);

///////////////////////
/////tested
///////////////////////

input [15:0] A,B;
output [15:0] SUM;
wire [7:0] Sum0,Sum1;
wire c0,c1,c2,c3,c4,c5,c6;
wire o0,o1,o2,o3,o4,o5,o6;
CLA CLA0(.A(A[3:0]),.B(B[3:0]),.SUM(Sum0[3:0]),.CIN(1'b0),.COUT(c0),.OVFL(o0));
CLA CLA1(.A(A[7:4]),.B(B[7:4]),.SUM(Sum0[7:4]),.CIN(c0),.COUT(c1),.OVFL(o1));

CLA CLA2(.A(A[11:8]),.B(B[11:8]),.SUM(Sum1[3:0]),.CIN(1'b0),.COUT(c2),.OVFL(o2));
CLA CLA3(.A(A[15:12]),.B(B[15:12]),.SUM(Sum1[7:4]),.CIN(c2),.COUT(c3),.OVFL(o3));

CLA CLA4(.A(Sum0[3:0]),.B(Sum1[3:0]),.SUM(SUM[3:0]),.CIN(1'b0),.COUT(c4),.OVFL(o4));
CLA CLA5(.A(Sum0[7:4]),.B(Sum1[7:4]),.SUM(SUM[7:4]),.CIN(c4),.COUT(c5),.OVFL(o5));
CLA CLA6(.A({3'b000,c1}),.B({3'b000,c3}),.SUM(SUM[11:8]),.CIN(c5),.COUT(c6),.OVFL(o6));
assign SUM[15:9] = {7{SUM[8]}};

endmodule