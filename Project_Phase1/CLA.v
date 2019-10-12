module CLA(A,B,SUM,OVFL,CIN,COUT);
input [3:0] A, B;
output[3:0] SUM;
input CIN;
output OVFL,COUT;
wire p0,p1,p2,p3, g0,g1,g2,g3, cout0,cout1,cout2,cout3, cin0,cin1,cin2,cin3;

assign p0 = A[0]^B[0];
assign p1 = A[1]^B[1];
assign p2 = A[2]^B[2];
assign p3 = A[3]^B[3];

assign g0 = A[0]&B[0];
assign g1 = A[1]&B[1];
assign g2 = A[2]&B[2];
assign g3 = A[3]&B[3];

assign cin0 = CIN;
assign cin1 = g0|(p0&cin0);
assign cin2 = g1|(p1&cin1);
assign cin3 = g2|(p2&cin2);
assign COUT = g3|(p3&cin3);

assign OVFL = (A[3]&B[3]&!SUM[3])|(!A[3]&!B[3]&SUM[3]);

full_adder_1bit FA0 (.a(A[0]),.b(B[0]),.result(SUM[0]),.cin(cin0),.cout(cout0));
full_adder_1bit FA1 (.a(A[1]),.b(B[1]),.result(SUM[1]),.cin(cin1),.cout(cout1));
full_adder_1bit FA2 (.a(A[2]),.b(B[2]),.result(SUM[2]),.cin(cin2),.cout(cout2));
full_adder_1bit FA3 (.a(A[3]),.b(B[3]),.result(SUM[3]),.cin(cin3),.cout(cout3));

endmodule