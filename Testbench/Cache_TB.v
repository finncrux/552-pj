module Cache_TB();
  

reg clk;
reg rst_n;

// Data Cache
reg[15:0]  DataIN_FSM_D;
reg[15:0]  DataIN_CPU_D;
reg[15:0]  Addr_CPU_D;
reg[15:0]  Addr_FSM_D;
reg W_D;
reg R_D;
reg MetaData_WE_D;
reg Data_WE_D;
wire[15:0] DataOUT_CPU_D;
wire Miss_D;
Cache_D DUT_D(.clk(clk),.rst_n(rst_n),.DataIn_FSM(DataIN_FSM_D),.DataIn_CPU(DataIN_CPU_D),
.DataOut_CPU(DataOUT_CPU_D),.Miss(Miss_D),.Addr_CPU(Addr_CPU_D),.Addr_FSM(Addr_FSM_D),
.MetaData_WE(MetaData_WE_D),.Data_WE(Data_WE_D),.R(R_D),.W(W_D));
// Metadata Cache
reg[15:0]  DataIN_FSM_I;
reg[15:0]  Addr_CPU_I;
reg[15:0]  Addr_FSM_I;
reg R_I;
reg MetaData_WE_I;
reg Data_WE_I;
wire[15:0] DataOUT_CPU_I;
wire Miss_I;
Cache_I DUT_I(.clk(clk),.rst_n(rst_n),.DataIn_FSM(DataIN_FSM_I),.DataOut_CPU(DataOUT_CPU_I)
,.Miss(Miss_I),.Addr_CPU(Addr_CPU_I),.Addr_FSM(Addr_FSM_I),
.MetaData_WE(MetaData_WE_I),.Data_WE(Data_WE_I),.R(R_I));

/*
reg[15:0]  DataIN_FSM_D;
reg[15:0]  DataIN_CPU_D;
reg[15:0]  Addr_CPU_D;
reg[15:0]  Addr_FSM_D;
reg W_D;
reg R_D;
reg MetaData_WE_D;
reg Data_WE_D;
reg[15:0]  DataIN_FSM_I;
reg[15:0]  Addr_CPU_I;
reg[15:0]  Addr_FSM_I;
reg R_I;
reg MetaData_WE_I;
reg Data_WE_I;
*/

initial begin
   clk = 0;
   rst_n = 0;
   
   #2 rst_n = 1;    // start!
end

always
#1 clk = !clk;

endmodule
