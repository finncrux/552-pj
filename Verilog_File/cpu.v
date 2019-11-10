module cpu(clk, rst_n, hlt, pc);
input clk, rst_n;
output hlt;
output[15:0] pc;
////////////////////////////////////////////
// IF //////////////////////////////////////
////////////////////////////////////////////



////////////////////////////////////////////
// IF/ID Reg ///////////////////////////////
////////////////////////////////////////////


////////////////////////////////////////////
// ID //////////////////////////////////////
////////////////////////////////////////////


////////////////////////////////////////////
// ID/EX Reg ///////////////////////////////
////////////////////////////////////////////


////////////////////////////////////////////
// EX //////////////////////////////////////
////////////////////////////////////////////

// I/O exposed
wire [2:0] FlagFromAlu;     // flag output from ALU
wire [15:0] MemFwdSource,ExFwdSource,Rs_Data,Rt_data;   // the data passed into ALU
wire RsMemFwd,RsExFwd;      // RS forwarding?
wire RtMemFwd,RtExFwd;      // Rt forwarding?
wire [15:0] RES;            // ALU result
wire [15:0] IMM;            // 16 bit immediate input
wire [3:0] OPOCODE;         // operation to execuate

// alu module
wire [15:0] A,B;
assign A = RsMemFwd?MemFwdSource:RsExFwd?ExFwdSource:Rs_Data;
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