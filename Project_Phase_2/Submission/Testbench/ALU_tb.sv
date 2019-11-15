module ALU_tb();
reg[3:0] opocode;
logic[15:0] RESULT,A,B,RES_R,RES_P,result;
logic[7:0]I;
wire VLD;
assign VLD = result == RESULT;
RED R(.A(A),.B(B),.SUM(RES_R));
PADDSB P(.A(A),.B(B),.RES(RES_P));


ALU ALU(.A(A),.B(B),.I(I),.RES(result),.opocode(opocode));


assign  RESULT =
        (opocode == 4'b0000)? A+B:
        (opocode == 4'b0001)? A-B:
        (opocode == 4'b0010)? A^B:
        (opocode == 4'b0011)? RES_R:
        (opocode == 4'b0100)? A<<1:
        (opocode == 4'b0101)? A>>>1:
        (opocode == 4'b0110)? {A[0],A[15:1]}:
        (opocode == 4'b0111)? RES_P:
        (opocode == 4'b1000)? 4'bxxxx:
        (opocode == 4'b1001)? 4'bxxxx:
        (opocode == 4'b1010)? {A[7:0],I}:
        (opocode == 4'b1011)? {I,A[7:0]}:
        (opocode == 4'b1100)? 4'bxxxx:
        (opocode == 4'b1101)? 4'bxxxx:
        (opocode == 4'b1110)? 4'bxxxx:
        (opocode == 4'b1111)? 4'bxxxx:
        4'bxxxx;

initial begin
    repeat(100)begin
        #1 
        opocode = $random%4'hf;
        A = $random%16'hffff;
        B = $random%16'hffff;
        I = $random%8'hff;
    end
    $stop;
end
endmodule