module PSA_16bit_tb();
reg[15:0] A, B;
wire[15:0] result,RESULT;
wire ERROR,error,VLD;
assign RESULT[3:0] = A[3:0] + B[3:0];
assign RESULT[7:4] = A[7:4] + B[7:4];
assign RESULT[11:8] = A[11:8] + B[11:8];
assign RESULT[15:12] = A[15:12] + B[15:12];

assign ERROR = RESULT!= A+B;
assign VLD = (result==RESULT) & (ERROR == error);
PSA_16bit PSA(.A(A),.B(B),.Sum(result),.Error(error));

initial begin
 #5 
    A = $urandom_range(65536,-65536);
    B = $urandom_range(65536,-65536);
 #5 
    A = $urandom_range(65536,-65536);
    B = $urandom_range(65536,-65536);
 #5 
    A = $urandom_range(65536,-65536);
    B = $urandom_range(65536,-65536);
 #5 
    A = $urandom_range(65536,-65536);
    B = $urandom_range(65536,-65536);
 #5 
    A = $urandom_range(65536,-65536);
    B = $urandom_range(65536,-65536);
 #5 
    A = $urandom_range(65536,-65536);
    B = $urandom_range(65536,-65536);
 #5 
    A = $urandom_range(65536,-65536);
    B = $urandom_range(65536,-65536);
 #5 
    A = $urandom_range(65536,-65536);
    B = $urandom_range(65536,-65536);
 #5 
    A = $urandom_range(65536,-65536);
    B = $urandom_range(65536,-65536);
 #5 
    A = $urandom_range(65536,-65536);
    B = $urandom_range(65536,-65536);
 #5 
    A = $urandom_range(65536,-65536);
    B = $urandom_range(65536,-65536);
 #5 
    A = $urandom_range(65536,-65536);
    B = $urandom_range(65536,-65536);

end
endmodule
