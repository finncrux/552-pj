module cpu(clk, rst_n, hlt, pc);

wire wrtEn_1;
assign wrtEn_1 = 1;

input clk, rst_n;
output hlt;
output[15:0] pc;
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
Register_16 RegRead2(.Q(_EX_ID), .D(_EX_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_16 IMM(.Q(IMM_ID), .D(IMM_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));



////////////////////////////////////////////
// EX //////////////////////////////////////
////////////////////////////////////////////

// I/O exposed
wire[2:0] FlagFromAlu;      // flag output from ALU
wire [15:0] MemFwdSource,ExFwdSource,Rs_Data_EX,_EX_EX;   // the data passed into ALU
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
wire [2:0] FlagFromAlu;     // flag output from ALU
wire [15:0] MemFwdSource,ExFwdSource,Rs_Data_EX,Rt_data_EX;   // the data passed into ALU
wire RsMemFwd,RsExFwd;      // RS forwarding?
wire RtMemFwd,RtExFwd;      // Rt forwarding?
wire [15:0] RES;            // ALU result
wire [15:0] IMM;            // 16 bit immediate input
wire [3:0] OPOCODE;         // operation to execuate

// alu module
wire [15:0] A,B;
assign A = RsMemFwd?MemFwdSource:RsExFwd?ExFwdSource:Rs_Data_EX;
assign B = RtMemFwd?MemFwdSource:RtExFwd?ExFwdSource:RtExFwd;
wire ALU_OVFL;
ALU alu(.A(A),.B(B),.I(IMM[7:0]),.RES(RES),.opocode(OPOCODE),.OVFL(ALU_OVFL));    

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


////////////////////////////////////////////
// FORWARDING UNIT /////////////////////////
////////////////////////////////////////////

// I/O exposed
wire [3:0] ID_EX_Rs,  ID_EX_Rt,          // Input: which reg does each stage needs
           EX_MEM_Rs, EX_MEM_Rt, EX_MEM_Rd;
wire ID_EX_Rs_EX_Fwd , ID_EX_Rt_EX_Fwd ;   // Output: EX take input from EX Fwd
wire ID_EX_Rs_MEM_Fwd , ID_EX_Rt_MEM_Fwd;  // Output: EX take input from MEM Fwd
wire EX_MEM_Rs_Fwd, EX_MEM_Rt_Fwd;        // Output: MEM take input from MEM Fwd
wire EX_MEM_Opocode_Vld, MEM_WB_Opocode_Vld;     // Input: whether the operation produce useful output in ALU.
                                          // If the operation is a load or save then the address is not useful.
assign ID_EX_Rs_Fwd = (ID_EX_Rs!=0) & (EX_MEM_Rd == ID_EX_Rs) & (EX_MEM_Opocode_Vld);
endmodule