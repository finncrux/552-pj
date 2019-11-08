module CLA_tb();

reg [3:0]A, B;
reg cin;
wire cout, ovfl;
wire [3:0]Sum;

CLA iDUT(.A(A),.B(B),.SUM(Sum),.OVFL(ovfl),.CIN(cin),.COUT(cout));

wire [3:0]checkarith;
assign checkarith = A + B + cin - Sum;

initial begin
    repeat(50) begin
        A = $random % 4'd15;
        B = $random % 4'd15;
        cin = 0;
        #5;
        cin = 1;
        #5;
    end
end


endmodule