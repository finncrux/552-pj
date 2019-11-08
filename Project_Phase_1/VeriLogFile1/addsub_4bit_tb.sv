module addsub_4bit_tb();
reg[3:0] A, B, SUM;
reg sub;
wire[3:0] RES;
wire OVFL,ovflres;
wire VLD;

initial begin

    #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
    #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
    #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
    #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
    #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
     #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
     #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
     #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
     #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
     #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
    #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
    #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
    #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
    #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
     #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
     #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
     #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
     #5
    A = $urandom_range(12,-12);
    B = $urandom_range(12,-12);
    sub = $urandom_range(1,0);
end

addsub_4bit Adder(.A(A),.B(B),.sub(sub),.Sum(RES),.Ovfl(ovflres));
// define clk

assign SUM = sub? A-B:A + B;
assign OVFL = sub?((!A[3])&(B[3])&(SUM[3]))|((A[3])&(!B[3])&(!SUM[3])) : ((A[3])&(B[3])&(!SUM[3]))|((!A[3])&(!B[3])&(SUM[3]));
assign VLD = (SUM === RES) & (OVFL === ovflres);

endmodule
