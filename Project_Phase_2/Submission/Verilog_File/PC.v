module PC(input clk, input rst,
            input[2:0] Condition, input[8:0] Imm, input [2:0] Flag, 
            output [15:0] PC_addr, output[15:0] PCS, input[15:0] PC_Reg_Addr, input[3:0] opcode);

wire [15:0] PC_out, PC_Reg_In;
wire rd_en, wt_en;

assign PCS = PC_out;
assign rd_en = 1'b1;
assign wt_en = 1'b1;
assign PC_Reg_In = (opcode == 4'hd) ? PC_Reg_Addr : PC_out;

PC_control pc_ctrl(.C(Condition),.I(Imm),.F(Flag),.PC_in(PC_addr),.PC_out(PC_out));
pc_reg pcreg(.rst(rst), .clk(clk), .PC_in(PC_Reg_In),.PC_out(PC_addr));


endmodule