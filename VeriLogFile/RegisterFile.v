module RegisterFile(input clk, input rst, input [3:0] SrcReg1, input [3:0] SrcReg2, input [3:0] DstReg, input WriteReg, input [15:0] DstData, inout [15:0] SrcData1, inout [15:0] SrcData2);
wire[15:0] WrtEn,RdEn1,RdEn2;
ReadDecoder_4_16 RDcoder1(.RegId(SrcReg1), .Wordline(RdEn1));
ReadDecoder_4_16 RDcoder2(.RegId(SrcReg2), .Wordline(RdEn2));
WriteDecoder_4_16 WDcoder(.RegId(DstReg), .WriteReg(WriteReg), .Wordline(WrtEn));

Register R0(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[0]), .ReadEnable1(RdEn1[0]), .ReadEnable2(RdEn2[0]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R1(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[1]), .ReadEnable1(RdEn1[1]), .ReadEnable2(RdEn2[1]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R2(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[2]), .ReadEnable1(RdEn1[2]), .ReadEnable2(RdEn2[2]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R3(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[3]), .ReadEnable1(RdEn1[3]), .ReadEnable2(RdEn2[3]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R4(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[4]), .ReadEnable1(RdEn1[4]), .ReadEnable2(RdEn2[4]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R5(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[5]), .ReadEnable1(RdEn1[5]), .ReadEnable2(RdEn2[5]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R6(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[6]), .ReadEnable1(RdEn1[6]), .ReadEnable2(RdEn2[6]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R7(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[7]), .ReadEnable1(RdEn1[7]), .ReadEnable2(RdEn2[7]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R8(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[8]), .ReadEnable1(RdEn1[8]), .ReadEnable2(RdEn2[8]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R9(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[9]), .ReadEnable1(RdEn1[9]), .ReadEnable2(RdEn2[9]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R10(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[10]), .ReadEnable1(RdEn1[10]), .ReadEnable2(RdEn2[10]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R11(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[11]), .ReadEnable1(RdEn1[11]), .ReadEnable2(RdEn2[11]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R12(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[12]), .ReadEnable1(RdEn1[12]), .ReadEnable2(RdEn2[12]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R13(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[13]), .ReadEnable1(RdEn1[13]), .ReadEnable2(RdEn2[13]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R14(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[14]), .ReadEnable1(RdEn1[14]), .ReadEnable2(RdEn2[14]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register R15(.clk(clk), .rst(rst), .D(DstData), .WriteReg(WrtEn[15]), .ReadEnable1(RdEn1[15]), .ReadEnable2(RdEn2[15]), .Bitline1(SrcData1), .Bitline2(SrcData2));

endmodule