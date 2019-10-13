module shifter(opcode, shift_in, shift_out, shift_val);

///////////////////////
/////tested
///////////////////////

input [3:0] opcode, shift_val;
input [15:0] shift_in;
output [15:0] shift_out;

wire [15:0] res1, res2, res3;
wire [15:0] temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9;

//SLL
assign temp1 = shift_val[3]? shift_in << 8 : shift_in;
assign temp2 = shift_val[2]? temp1 << 4 : temp1;
assign temp3 = shift_val[1]? temp2 << 2 : temp2;
assign res1 =  shift_val[0]? temp3 << 1 : temp3;

//SRA
assign temp4 = shift_val[3]? {{8{shift_in[15]}}, shift_in[15:8]} : shift_in;
assign temp5 = shift_val[2]? {{4{shift_in[15]}}, temp4[15:4]} : temp4;
assign temp6 = shift_val[1]? {{2{shift_in[15]}}, temp5[15:2]} : temp5;
assign res2 =  shift_val[0]? {shift_in[15], temp6[15:1]} : temp6;

//ROR
assign temp7 = shift_val[3]? {shift_in[7:0], shift_in[15:8]} : shift_in;
assign temp8 = shift_val[2]? {temp7[3:0], temp7[15:4]} : temp7;
assign temp9 = shift_val[1]? {temp8[1:0], temp8[15:2]} : temp8;
assign res3 =  shift_val[0]? {temp9[0], temp9[15:1]} : temp9;

assign shift_out =  (!opcode[0] & !opcode[1]) ? res1 :
                    (!opcode[1] & opcode[0])  ? res2 : res3;


endmodule