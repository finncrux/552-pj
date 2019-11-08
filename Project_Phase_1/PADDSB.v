module PADDSB(A,B,RES);
input[15:0] A,B;
output[15:0] RES;
wire[3:0]sum0,sum1,sum2,sum3;
wire ovfl0,ovfl1,ovfl2,ovfl3;
wire cout0,cout1,cout2,cout3;
CLA_4bit cla0(.A(A[3:0]),.B(B[3:0]),.S(sum0),.Ovfl(ovfl0),.Cin(1'b0),.G(),.P(),.Cout());
CLA_4bit cla1(.A(A[7:4]),.B(B[7:4]),.S(sum1),.Ovfl(ovfl1),.Cin(1'b0),.G(),.P(),.Cout());
CLA_4bit cla2(.A(A[11:8]),.B(B[11:8]),.S(sum2),.Ovfl(ovfl2),.Cin(1'b0),.G(),.P(),.Cout());
CLA_4bit cla3(.A(A[15:12]),.B(B[15:12]),.S(sum3),.Ovfl(ovfl3),.Cin(1'b0),.G(),.P(),.Cout());

assign RES = {ovfl3?(sum3[3]?4'h7:4'h8):sum3[3:0],
              ovfl2?(sum2[3]?4'h7:4'h8):sum2[3:0],
              ovfl1?(sum1[3]?4'h7:4'h8):sum1[3:0],
              ovfl0?(sum0[3]?4'h7:4'h8):sum0[3:0]
            };
endmodule
