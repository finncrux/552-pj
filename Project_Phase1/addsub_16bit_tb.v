module addsub_16bit_tb();
reg signed [15:0] A, B;
wire signed[15:0] Sum;
reg sub;
wire signed [15:0] RES;
wire OVFL;
wire VLD;
wire [15:0]Sum1;
wire o;

initial begin
    repeat(50) begin
        A = $random % 16'hffff;
        B = $random % 16'hffff;
        sub = 0;
        #5;
        sub = 1;
        #5;

    end
end

addsub_16bit Adder(.A(A),.B(B),.sub(sub),.Sum(RES), .Ovfl(o));
// define clk

assign Sum = sub? A-B:A + B;
assign OVFL = sub?((!A[15])&(B[15])&(Sum[15]))|((A[15])&(!B[15])&(!Sum[15])) : ((A[15])&(B[15])&(!Sum[15]))|((!A[15])&(!B[15])&(Sum[15]));
assign Sum1 = OVFL? (Sum[15]? (16'h7fff) : 16'h8000 ): Sum;
assign VLD = (Sum1 === RES);

endmodule
