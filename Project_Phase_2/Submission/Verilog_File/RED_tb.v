module RED_tb();

reg signed [15:0]A, B;
wire signed [15:0 ]Sum;
wire signed[9:0]SUM;
RED iDUT(.A(A), .B(B), .SUM(Sum));

wire [15:0] checkarith;
assign SUM = A[7:0] + A[15:8] + B[7:0] + B[15:8];
assign checkarith =SUM - Sum;

initial begin
    repeat(50) begin
        A = $random % 16'hffff;
        B = $random % 16'hffff;
        #5;
    end
end

endmodule