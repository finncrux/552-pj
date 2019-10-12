module addsub_16bit_tb();
reg signed [15:0] A, B;
wire signed[15:0] SUM;
reg sub;
wire signed [15:0] RES;
wire OVFL,ovflres;
wire VLD;

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

addsub_16bit Adder(.A(A),.B(B),.sub(sub),.SUM(RES));
// define clk

assign SUM = sub? A-B:A + B;
assign OVFL = sub?((!A[15])&(B[15])&(SUM[15]))|((A[15])&(!B[15])&(!SUM[15])) : ((A[15])&(B[15])&(!SUM[15]))|((!A[15])&(!B[15])&(SUM[15]));
assign VLD = (SUM === RES);

endmodule
