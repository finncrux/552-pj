module PADDSB_tb();
reg[15:0] A,B;
wire[15:0] result,RESULT;
wire ovfl0,ovfl1,ovfl2,ovfl3,vld;
wire[4:0] s0,s1,s2,s3;
assign s0 = A[3:0]+B[3:0];
assign s1 = A[7:4]+B[7:4];
assign s2 = A[11:8]+B[11:8];
assign s3 = A[15:12]+B[15:12];

PADDSB test (.A(A),.B(B),.RES(result));
assign ovfl0 = (A[3]==B[3])&(A[3]!=s0[3]);
assign ovfl1 = (A[7]==B[7])&(A[7]!=s1[3]);
assign ovfl2 = (A[11]==B[11])&(A[11]!=s2[3]);
assign ovfl3 = (A[15]==B[15])&(A[15]!=s3[3]);

assign RESULT = {(ovfl3?(A[15]?4'h8:4'h7):(s3[3:0])),(ovfl2?(A[11]?4'h8:4'h7):(s2[3:0])),(ovfl1?(A[7]?4'h8:4'h7):(s1[3:0])),(ovfl0?(A[3]?4'h8:4'h7):(s0[3:0]))};
assign vld = (result === RESULT);

initial begin
    repeat(50)begin
    #5
    A = $random% 16'hffff;
    B = $random% 16'hffff;
    end
end

endmodule