module addsub_16bit(A, B, SUM, sub);

input sub;
input [15:0]A, B;
output [15:0]SUM;

wire [15:0]real_B, SUM_CAL;
wire cin1, cin2, cin3, cout4, ovfl1, ovfl2, ovfl3, ovfl_final;

assign real_B = sub? ~B : B;

CLA c1(.A(A[3:0]),.B(real_B[3:0]),.SUM(SUM_CAL[3:0]),.OVFL(ovfl1),.CIN(sub),.COUT(cin1));
CLA c2(.A(A[7:4]),.B(real_B[7:4]),.SUM(SUM_CAL[7:4]),.OVFL(ovfl2),.CIN(cin1),.COUT(cin2));
CLA c3(.A(A[11:8]),.B(real_B[11:8]),.SUM(SUM_CAL[11:8]),.OVFL(ovfl3),.CIN(cin2),.COUT(cin3));
CLA c4(.A(A[15:12]),.B(real_B[15:12]),.SUM(SUM_CAL[15:12]),.OVFL(ovfl_final),.CIN(cin3),.COUT(cout4));

assign SUM = ovfl_final? (SUM_CAL[15] ? 16'h7fff : 16'h8000) : SUM_CAL;

endmodule