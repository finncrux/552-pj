module RegisterFile_tb();
reg clk, wrtEn,rst;
reg[3:0] ReadDest1, ReadDest2, WriteDest;
reg[15:0] DataIn;
wire[15:0] DataOut1,DataOut2;
RegisterFile RG(.clk(clk),.rst(rst),.SrcReg1(ReadDest1),.SrcReg2(ReadDest2),.DstReg(WriteDest), .WriteReg(wrtEn), .DstData(DataIn), .SrcData1(DataOut1), .SrcData2(DataOut2));
initial begin
#1 clk = 0;
    rst = 1;
    DataIn = 16'h00ff;
    wrtEn = 0;
    ReadDest1 = 0;
    ReadDest2 = 0;
    WriteDest = 0;
#1 
    rst = 0;
#5  
    WriteDest = 2;
    DataIn = 16'h03fe;
    wrtEn = 1;
    ReadDest1 = 2;
#1  wrtEn = 0;
#1  
    WriteDest = 13;
    DataIn = 16'hdddd;
    wrtEn = 1;
    ReadDest2 = 13;
#1  wrtEn = 0;
#1  
    WriteDest = 13;
    DataIn = 16'hddff;
    wrtEn = 0;
    ReadDest2 = 13;
#1  wrtEn = 0;
end

always
    #1 clk = ~clk;

endmodule
