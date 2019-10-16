///////////////////////
// TEST PASSED
//////////////////////
module ALU(A,B,I,RES,opocode,OVFL);
input [3:0] opocode;
input [15:0] A,B; // A:RS, B:RD
input [7:0] I;
output [15:0] RES;
output OVFL;
wire[15:0] result_ADDSUB,result_PADDSB,result_RED,result_SHIFTER;

RED redder(.A(A),.B(B),.SUM(result_RED));
addsub_16bit adder(.A((opocode[3:1] == 3'b100)?({{11{I[3]}},I[3:0],1'b0}):A), .B(B), .Sum(result_ADDSUB), .sub(opocode == 4'b0001),.Ovfl(OVFL));
PADDSB padder(.A(A),.B(B),.RES(result_PADDSB));
shifter shifter(.opcode(opocode), .shift_in(A), .shift_out(result_SHIFTER), .shift_val(I[3:0]));// need varify

assign RES = (&opocode[2:0])?result_PADDSB:
            (opocode == 4'b0011)?result_RED:
            (opocode == 4'b0010)?A^B:
            (opocode[3:2] == 2'b01)?result_SHIFTER:
            (opocode == 4'b1011)?{I,A[7:0]}:
            (opocode == 4'b1010)?{A[15:8],I}:
            result_ADDSUB;
endmodule