module pc_reg(rst, clk, PC_in, PC_out);

input rst, clk;
input [15:0]PC_in;
output reg [15:0]PC_out;

always@(posedge rst, posedge clk) begin
    if(rst) begin
        PC_out <= 16'h0000;
    end
    else
        PC_out <= PC_in;
end

endmodule