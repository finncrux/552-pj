module shifter_6(shift_out, shift_val);

///////////////////////
/////tested
///////////////////////

input [5:0]    shift_val;
output [127:0] shift_out;

wire [127:0] temp1, temp2, temp3, temp4, temp5;

//SLL
assign temp1 =  shift_val[0]? 128'h1 << 1 : 128'h1;
assign temp2 =  shift_val[1]? temp1 << 2 : temp1;
assign temp3 =  shift_val[2]? temp2 << 4 : temp2;
assign temp4 =  shift_val[3]? temp3 << 8 : temp3;
assign temp5 =  shift_val[4]? temp3 << 16 : temp4;
assign shift_out =  shift_val[5]? temp3 << 32 : temp5;

endmodule