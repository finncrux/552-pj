module RED(A,B,SUM);
input [15:0] A,B;
output [15:0] SUM;
wire [7:0] Sum0,Sum1;
wire c0,c1,c2,c3,c4,c5,c6;

CLA CLA0(.A(A[3:0]),.B(B[3:0]),.SUM(Sum0[3:0]),.CIN(0),.COUT(c0));
CLA CLA1(.A(A[7:4]),.B(B[7:4]),.SUM(Sum0[7:4]),.CIN(c0),.COUT(c1));

CLA CLA2(.A(A[11:8]),.B(B[11:8]),.SUM(Sum1[3:0]),.CIN(0),.COUT(c2));
CLA CLA3(.A(A[15:12]),.B(B[15:12]),.SUM(Sum1[7:4]),.CIN(c2),.COUT(c3));

CLA CLA4(.A(Sum0[3:0]),.B(Sum1[3:0]),.SUM(SUM[3:0]),.CIN(0),.COUT(c4));
CLA CLA5(.A(Sum0[7:4]),.B(Sum1[7:4]),.SUM(SUM[7:4]),.CIN(c4),.COUT(c5));
CLA CLA6(.A({3'b000,c1}),.B({3'b000,c3}),.SUM(SUM[11:8]),.CIN(c5),.COUT(c6));
assign SUM[15:10] = {6{SUM[9]}};

endmodule