module PADDSB (Sum, Error, A, B);
input [15:0] A, B; 	// Input data values
output [15:0] Sum; 	// Sum output
output Error; 	// To indicate overflows
wire ovfl1,ovfl2,ovfl3,ovfl4;

addsub_4bit RA1(.Sum(Sum[3:0]), .Ovfl(ovfl1), .A(A[3:0]), .B(B[3:0]), .sub(1'b0));
addsub_4bit RA2(.Sum(Sum[7:4]), .Ovfl(ovfl2), .A(A[7:4]), .B(B[7:4]), .sub(1'b0));
addsub_4bit RA3(.Sum(Sum[11:8]), .Ovfl(ovfl3), .A(A[11:8]), .B(B[11:8]), .sub(1'b0));
addsub_4bit RA4(.Sum(Sum[15:12]), .Ovfl(ovfl4), .A(A[15:12]), .B(B[15:12]), .sub(1'b0));
assign Error = ovfl1|ovfl2|ovfl3|ovfl4;
endmodule

