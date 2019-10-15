
module addsub_4bit (Sum, Ovfl, A, B, sub);
input [3:0] A, B; //Input values
input sub; // add-sub indicator
output [3:0] Sum; //sum output
output Ovfl; //To indicate overflow

wire cin2,cin3,cin4,cout4,B1,B2,B3,B4;
assign B1 = sub?(B[0]^1):B[0];  // instantiate 4 mux
assign B2 = sub?(B[1]^1):B[1];
assign B3 = sub?(B[2]^1):B[2];
assign B4 = sub?(B[3]^1):B[3];
assign cin1 = sub;              // cin of add  or sub
assign Ovfl = cin4 ^ cout4;     // whether  the final addition overflowed
full_adder_1bit FA1 (.a(A[0]),.b(B1),.cin(sub),.cout(cin2),.result(Sum[0])); 
full_adder_1bit FA2 (.a(A[1]),.b(B2),.cin(cin2),.cout(cin3),.result(Sum[1])); 
full_adder_1bit FA3 (.a(A[2]),.b(B3),.cin(cin3),.cout(cin4),.result(Sum[2])); 
full_adder_1bit FA4 (.a(A[3]),.b(B4),.cin(cin4),.cout(cout4),.result(Sum[3])); 

endmodule