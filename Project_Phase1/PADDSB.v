module PADDSB(A,B,RES);
input[15:0] A,B;
output[15:0] RES;
wire[3:0]sum0,sum1,sum2,sum3;
wire ovfl0,ovfl1,ovfl2,ovfl3;
wire cout0,cout1,cout2,cout3;
CLA cla0(.A(A[3:0]),.B(B[3:0]),.SUM(sum0),.OVFL(ovfl0),.CIN(1'b0),.COUT(cout0));
CLA cla1(.A(A[7:4]),.B(B[7:4]),.SUM(sum1),.OVFL(ovfl1),.CIN(1'b0),.COUT(cout1));
CLA cla2(.A(A[11:8]),.B(B[11:8]),.SUM(sum2),.OVFL(ovfl2),.CIN(1'b0),.COUT(cout2));
CLA cla3(.A(A[15:12]),.B(B[15:12]),.SUM(sum3),.OVFL(ovfl3),.CIN(1'b0),.COUT(cout3));

assign RES = {ovfl3?(sum3[3]?4'h7:4'h8):sum3[3:0],
              ovfl2?(sum2[3]?4'h7:4'h8):sum2[3:0],
              ovfl1?(sum1[3]?4'h7:4'h8):sum1[3:0],
              ovfl0?(sum0[3]?4'h7:4'h8):sum0[3:0]
            };
endmodule
