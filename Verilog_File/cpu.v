module cpu(clk, rst_n, hlt, pc);

wire wrtEn_1;
assign wrtEn_1 = 1;

////////////////////////////////////////////
// IF //////////////////////////////////////
////////////////////////////////////////////



////////////////////////////////////////////
// IF/ID Reg ///////////////////////////////
////////////////////////////////////////////

// I/O exposed
wire IF_ID_Write;

// Data Reg
Register_16 PC(.Q(PC_IF), .D(PC_ID), .clk(clk), .rst(!rst_n), .wrtEn(IF_ID_Write));
Register_16 Instr(.Q(Instr_IF), .D(Instr_ID), .clk(clk), .rst(!rst_n), .wrtEn(IF_ID_Write));


////////////////////////////////////////////
// ID //////////////////////////////////////
////////////////////////////////////////////



////////////////////////////////////////////
// ID/EX Reg ///////////////////////////////
////////////////////////////////////////////

// Control Reg

// Data Reg
Register_16 RegRead1(.Q(Rs_Data_ID), .D(Rs_Data_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_16 RegRead2(.Q(Rt_Data_ID), .D(Rt_data_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_16 IMM(.Q(IMM_ID), .D(IMM_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));



////////////////////////////////////////////
// EX //////////////////////////////////////
////////////////////////////////////////////

// I/O exposed
wire[2:0] FlagFromAlu;      // flag output from ALU
wire [15:0] MemFwdSource,ExFwdSource,Rs_Data_EX,Rt_data_EX;   // the data passed into ALU
wire RsMemFwd,RsExFwd;      // RS forwarding?
wire RtMemFwd,RtExFwd;      // Rt forwarding?
wire [15:0] RES;            // ALU result
wire [15:0] IMM_EX;            // 16 bit immediate input
wire [3:0] opocode;         // operation to execuate

// alu module
wire [15:0] A,B,RES;
assign A = RsMemFwd?MemFwdSource:RsExFwd?ExFwdSource:Rs_Data_EX;
assign B = RtMemFwd?MemFwdSource:RtExFwd?ExFwdSource:RtExFwd;
wire OVFL;
ALU alu(.A(A),.B(B),.I(IMM_EX[7:0]),.RES(RES),.opocode(opocode),.OVFL(OVFL));    

// Flag logic
assign FlagFromAlu = {(RES==0),(ALU_OVFL),(RES[15]==1)};
assign WriteEnableN =!(|OPOCODE[3:1]);
assign WriteEnableZ = WriteEnableN|(OPOCODE==4'b0010)|(OPOCODE==4'b0100)|(OPOCODE==4'b0101)|(OPOCODE==4'b0110);
assign WriteEnableV =!(|OPOCODE[3:1]);
Register_3 FLAGREG(.Q(FLAG),.D(FlagFromAlu),.clk(clk),.rst(!rst_n),.WriteEnableN(WriteEnableN)
,.WriteEnableZ(WriteEnableZ),.WriteEnableV(WriteEnableV));

////////////////////////////////////////////
// EX/MEM Reg //////////////////////////////
////////////////////////////////////////////


////////////////////////////////////////////
// MEM /////////////////////////////////////
////////////////////////////////////////////


////////////////////////////////////////////
// MEM/WB Reg //////////////////////////////
////////////////////////////////////////////


////////////////////////////////////////////
// WB //////////////////////////////////////
////////////////////////////////////////////



endmodule