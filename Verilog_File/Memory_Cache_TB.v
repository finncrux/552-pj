module Memory_Cache_TB();
reg       clk,rst_n;
reg       Write;
reg       Read;
reg [3:0] OPOCODE;
reg[15:0] Addr;
reg[7:0]  DataIn;
wire[7:0] DataOut;
wire      Stall;
reg      CLK_RESET_DEBUG;
wire [3:0] Clock_VALUE;
Memory_Cache MC(.clk(clk),.rst_n(rst_n),.Write(Write),.Read(Read),.DataIn(DataIn),.CLK_RESET_DEBUG(CLK_RESET_DEBUG),
.DataOut(DataOut),.Stall(Stall),.Addr(Addr),.OPOCODE(OPOCODE));//,Write,Read,DataIn,DataOut,Stall,Addr);
assign Clock_VALUE = MC.CLK_OUT;

initial
begin
    #1 clk = 0;
    #1 rst_n = 0;
    #3 rst_n = 1;
    #2 CLK_RESET_DEBUG = 1'b1;
    #2 CLK_RESET_DEBUG = 1'b0;
    #16 CLK_RESET_DEBUG = 1'b1;
    #2 CLK_RESET_DEBUG = 1'b0;


end

always
#1 clk = !clk;

endmodule