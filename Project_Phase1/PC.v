module PC(input clk, input rst,
            input[2:0] Condition, input[8:0] Imm, input [2:0] Flag, 
            output [15:0] PC_addr, output[15:0] PCS);

wire [15:0] PC_out,dead_line;
wire rd_en, wt_en, dead;

assign PCS = PC_out;
assign rd_en = 1'b1;
assign wt_en = 1'b1;

PC_control pc_ctrl(.C(Condition),.I(Imm),.F(Flag),.PC_in(PC_addr),.PC_out(PC_out));
pc_reg pcreg(.rst(rst), .clk(clk), .PC_in(PC_in), .PC_out(PC_out));


endmodule