module addsub_16bit(A, B, SUM, sub, ovfl);

///////////////////////
/////tested
///////////////////////

input sub;
input [15:0]A, B;
output [15:0]SUM;
output ovfl;

wire [15:0]real_B, SUM_CAL;
wire cin1, cin2, cin3, cout4, ovfl1, ovfl2, ovfl3, ovfl_final;
wire g1, p1, g2, p2, g3, p3, g4, p4;

assign real_B = sub? ~B : B;

assign g1 = (A[3]&real_B[3]) | ((A[3]^real_B[3])&(A[2]&real_B[2])) | ((A[3]^real_B[3])&(A[2]^real_B[2])&(A[1] & real_B[1])) |
            ((A[3]^real_B[3])&(A[2]^real_B[2])&(A[1]^real_B[1])&(A[0] & real_B[0]));
assign p1 = ((A[3]^real_B[3])& (A[2]^real_B[2]) & (A[1]^real_B[1])&(A[0]^real_B[0]));

assign g2 = (A[7]&real_B[7]) | ((A[7]^real_B[7])&(A[6]&real_B[6])) | ((A[7]^real_B[7])&(A[6]^real_B[6])&(A[5] & real_B[5])) |
            ((A[7]^real_B[7])&(A[6]^real_B[6])&(A[5]^real_B[5])&(A[4] & real_B[4]));
assign p2 = ((A[7]^real_B[7])& (A[6]^real_B[6]) & (A[5]^real_B[5])&(A[4]^real_B[4]));

assign g3 = (A[11]&real_B[11]) | ((A[11]^real_B[11])&(A[10]&real_B[10])) | ((A[11]^real_B[11])&(A[10]^real_B[10])&(A[9] & real_B[9])) |
            ((A[11]^real_B[11])&(A[10]^real_B[10])&(A[9]^real_B[9])&(A[8] & real_B[8]));
assign p3 = ((A[11]^real_B[11])& (A[10]^real_B[10]) & (A[9]^real_B[9])&(A[8]^real_B[8]));

CLA c1(.A(A[3:0]),.B(real_B[3:0]),.SUM(SUM_CAL[3:0]),.OVFL(ovfl1),.CIN(sub),.COUT(cin1));
CLA c2(.A(A[7:4]),.B(real_B[7:4]),.SUM(SUM_CAL[7:4]),.OVFL(ovfl2),.CIN(g1 | (p1 & sub)),.COUT(cin2));
CLA c3(.A(A[11:8]),.B(real_B[11:8]),.SUM(SUM_CAL[11:8]),.OVFL(ovfl3),.CIN((g2 | (p2&g1) | (p2&p1&sub))),.COUT(cin3));
CLA c4(.A(A[15:12]),.B(real_B[15:12]),.SUM(SUM_CAL[15:12]),.OVFL(ovfl_final),.CIN((g3 | p3&g2 | p3&p2&g1 | p3&p2&p1&sub)),.COUT(cout4));

assign ovfl = ovfl_final;
assign SUM = ovfl_final? (SUM_CAL[15] ? 16'h7fff : 16'h8000) : SUM_CAL;

endmodule