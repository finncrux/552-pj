module full_adder_1bit(a,b,result,cin,cout);
input a,b,cin;
output result;
output cout;
assign cout = (a&b) | (cin&a) | (cin&b);
assign result = a^b^cin;
endmodule