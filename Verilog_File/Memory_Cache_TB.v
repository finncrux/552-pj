module Memory_Cache_TB();
input           clk,rst_n;
input [3:0]     opcode;
input [15:0]    I_addr, Data_addr, D_Data_in;
output[15:0]    I_Data_out, D_Data_out;
output          Stall;

wire        rst, W, R;


Memory_Cache MC(.clk(clk), .rst_n(rst_n), .I_addr(I_addr), .I_Data_out(I_Data_out), .opcode(opcode), 
                .D_Data_in(D_Data_in), .Data_addr(Data_addr), .D_Data_out(D_Data_out), .Stall(Stall));


initial begin
    #1 clk = 0;
    #1 rst_n = 0;
    #3 rst_n = 1;


    #2 opcode = 4'b1001;
    I_addr = 16'h0000;
    Data_addr = 16'h0001;


    #20 I_addr = 16'h0001;


end

always
#1 clk = !clk;

endmodule