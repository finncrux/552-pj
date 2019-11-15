module PC_control_tb();

reg [2:0]C, F;
reg [15:0] PC_in;
reg [8:0] I;
wire [15:0]PC_out;

PC_control iDUT(.C(C), .I(I), .F(F), .PC_in(PC_in), .PC_out(PC_out));

initial begin
    I = $random % 9'h1ff;
    PC_in = $random % 16'hffff;
    C = 3'b000;
    repeat (50) begin
        C = C + 1'b1;
        F = $random % 3'b111;
        #5;
    end
end 

endmodule