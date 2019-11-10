module cpu(clk, rst_n, hlt, pc);

//Global Signal
input clk, rst_n;
output hlt;
output[15:0] pc;

wire Stall;             //From Hazard Detection
wire Flush;             //From Hazard Detection
wire wrtEn_1;
assign wrtEn_1 = 1;

////////////////////////////////////////////
// IF ////////////////////////////////////// OK
////////////////////////////////////////////

// I/O External
wire Branch_Hazard;     //Branch signal from Hazard Detection Unit
wire [15:0] PC_Branch;  //PC value, if added from branch offset

// I/O Internal
wire [15:0] PC_Reg_IN, PC_Reg_OUT, Instr_IF;
wire [15:0] PC_2;
wire Ovfl;
wire PCWrite;

wire PC_Rd, PC_Wrt, Ovfl;
assign PC_Rd = 1'b1;
assign PC_Wrt = 1'b0;

//Stall Condition
assign PCWrite = Stall ? 0 : 1;

//PC Reg IN Select Mux
assign PC_Reg_IN = Branch_Hazard ? PC_Branch : PC_2;

//PC Reg
pc_reg pcreg(.rst(rst), .clk(clk), .PC_in(PC_Reg_IN), .PC_out(PC_Reg_OUT), .PCWrite(PCWrite));

//PC Add 2
addsub_16bit PC_adder(.A(PC_Reg_OUT), .B(16'h0002), .Sum(PC_2), .sub(1'b0),.Ovfl(Ovfl));

//Instruction Memory
memory_I InstructionMem (.data_out(Instr_IF), .data_in(PC_Reg_OUT), .addr(PC_Reg_OUT), .enable(PC_Rd), .wr(PC_Wrt), .clk(clk), .rst(!rst_n));

////////////////////////////////////////////
// IF/ID Reg /////////////////////////////// OK
////////////////////////////////////////////

// I/O Internal
wire IF_ID_Write;   //Set to 0 if stall
wire IF_Flush;      //Set to 1 if flush

assign IF_ID_Write = Stall ? 0 : 1;
assign IF_Flush = Flush;

// Data Reg
Register_16 PC(.Q(PC_IF), .D(PC_ID), .clk(clk), .rst(!rst_n), .wrtEn(IF_ID_Write));
Register_16 Instr(.Q(Instr_IF), .D(Instr_ID), .clk(clk), .rst(!rst_n || IF_Flush), .wrtEn(IF_ID_Write));


////////////////////////////////////////////
// ID //////////////////////////////////////
////////////////////////////////////////////

// I/O Expose
wire [15:0] RegWrt_Data;


////////////////////////////////////////////
// ID/EX Reg /////////////////////////////// OK
////////////////////////////////////////////

// I/O Control
wire [3:0] ALUOp_EX;
wire ALUSrc_EX, RegDst_EX;      //EX
wire MemRead_EX, MemWrt_EX;     //M
wire MemToReg_EX, RegWrt_EX;    //WB

// I/O Data
wire [15:0] Rs_Data_EX, Rt_Data_EX, IMM_EX;
wire [3:0] Rs_EX, Rt_EX, Rd_EX;

// Control Reg EX
Register_4 ALUOp(.Q(ALUOp_ID), .D(ALUOp_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 ALUSrc(.Q(ALUSrc_ID), .D(ALUSrc_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 RegDst(.Q(RegDst_ID), .D(RegDst_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Control Reg M
Register_1 MemRead_id(.Q(MemRead_ID), .D(MemRead_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 MemWrite_id(.Q(MemWrt_ID), .D(MemWrt_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Control Reg WB
Register_1 MemToReg_id(.Q(MemToReg_ID), .D(MemToReg_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 RegWrt_id(.Q(RegWrt_ID), .D(RegWrt_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Data Reg
Register_16 RegRead1(.Q(Rs_Data_ID), .D(Rs_Data_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_16 RegRead2(.Q(Rt_Data_ID), .D(Rt_Data_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_16 IMM(.Q(IMM_ID), .D(IMM_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

Register_4 Rs(.Q(Rs_ID), .D(Rs_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_4 Rt(.Q(Rt_ID), .D(Rt_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_4 Rd(.Q(Rd_ID), .D(Rd_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));


////////////////////////////////////////////
// EX ////////////////////////////////////// OK
////////////////////////////////////////////

// I/O exposed
wire[2:0] FlagFromAlu;      // flag output from ALU
wire [15:0] MemFwdSource,ExFwdSource;//,Rs_Data_EX,Rt_Data_EX;   // the data passed into ALU
wire RsMemFwd,RsExFwd;      // RS forwarding?
wire RtMemFwd,RtExFwd;      // Rt forwarding?
wire [15:0] RES_EX;            // ALU result
//wire [15:0] IMM_EX;            // 16 bit immediate input

// alu module
wire [3:0] OPOCODE;         // operation to execuate
wire [15:0] A,B;
assign A = RsMemFwd?MemFwdSource:RsExFwd?ExFwdSource:Rs_Data_EX;
assign B = RtMemFwd?MemFwdSource:RtExFwd?ExFwdSource:RtExFwd;
wire ALU_OVFL;
ALU alu(.A(A),.B(B),.I(IMM_EX[7:0]),.RES(RES_EX),.opocode(OPOCODE),.OVFL(ALU_OVFL));    
//wire [2:0] FlagFromAlu;     // flag output from ALU
//wire [15:0] MemFwdSource,ExFwdSource,Rs_Data_EX,Rt_data_EX;   // the data passed into ALU
//wire RsMemFwd,RsExFwd;      // RS forwarding?
//wire RtMemFwd,RtExFwd;      // Rt forwarding?
//wire [15:0] IMM;            // 16 bit immediate input



// Flag logic
assign FlagFromAlu = {(RES_EX==0),(ALU_OVFL),(RES_EX[15]==1)};
assign WriteEnableN =!(|OPOCODE[3:1]);
assign WriteEnableZ = WriteEnableN|(OPOCODE==4'b0010)|(OPOCODE==4'b0100)|(OPOCODE==4'b0101)|(OPOCODE==4'b0110);
assign WriteEnableV =!(|OPOCODE[3:1]);
Register_3 FLAGREG(.Q(FLAG),.D(FlagFromAlu),.clk(clk),.rst(!rst_n),.WriteEnableN(WriteEnableN)
,.WriteEnableZ(WriteEnableZ),.WriteEnableV(WriteEnableV));

////////////////////////////////////////////
// EX/MEM Reg ////////////////////////////// OK
////////////////////////////////////////////

//I/O Expose Control
wire MemRead_MEM, MemWrt_MEM;   //M
wire MemToReg_MEM, RegWrt_MEM;  //WB

// I/O Expose Data
wire [15:0] MemWrt_Data_MEM, MemAddr_MEM;
wire [3:0] Rd_MEM;

// Control Reg M
Register_1 MemRead_ex(.Q(MemRead_EX), .D(MemRead_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 MemWrite_ex(.Q(MemWrt_EX), .D(MemWrt_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Control Reg WB
Register_1 MemToReg_ex(.Q(MemToReg_EX), .D(MemToReg_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 RegWrt_ex(.Q(RegWrt_EX), .D(RegWrt_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Data Reg
Register_16 RES_Reg(.Q(RES_EX), .D(MemAddr_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_16 B_Reg(.Q(B), .D(MemWrt_Data_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_4 Rd_ex(.Q(Rd_EX), .D(Rd_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));


////////////////////////////////////////////
// MEM ///////////////////////////////////// OK
////////////////////////////////////////////

// I/O External
wire [15:0] MemRead_Data_MEM;

// Data Memory
memory_D DataMemory(.data_out(MemRead_Data_MEM), .data_in(MemWrt_Data_MEM), .addr(MemAddr_MEM), .enable(MemRead_MEM), .wr(MemWrt_MEM), .clk(clk), .rst(!rst_n));


////////////////////////////////////////////
// MEM/WB Reg ////////////////////////////// OK
////////////////////////////////////////////

//I/O Expose Control
wire MemToReg_WB, RegWrt_WB;

// I/O Expose Data
wire [15:0] MemRead_Data_WB, MemWrt_Data_WB;
wire [3:0] Rd_WB;

// Control Reg WB
Register_1 MemToReg_mem(.Q(MemToReg_MEM), .D(MemToReg_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 RegWrt_mem(.Q(RegWrt_MEM), .D(RegWrt_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Data Reg
Register_16 MemRead_Data(.Q(MemRead_Data_MEM), .D(MemRead_Data_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_16 MemWrt_Data(.Q(MemWrt_Data_MEM), .D(MemWrt_Data_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_4 Rd_mem(.Q(Rd_MEM), .D(Rd_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

////////////////////////////////////////////
// WB ////////////////////////////////////// OK
////////////////////////////////////////////

// I/O External
//wire [15:0] RegWrt_Data;

//Select RegWrt Data
assign RegWrt_Data = MemToReg_WB ? MemRead_Data_WB : MemWrt_Data_WB;

////////////////////////////////////////////
// FORWARDING UNIT ///////////////////////// OK
////////////////////////////////////////////

// I/O exposed
// How to read?
// e.g ID_EX_Rs_MEM_Fwd means in ID/EX stage, Rs take forwarding input from MEM stage

wire[3:0]  ID_EX_Rs,  ID_EX_Rt,                 
           EX_MEM_Rs, EX_MEM_Rt, EX_MEM_Rd,
           MEM_WB_Rs, MEM_WB_Rt, MEM_WB_Rd;     // Input: which reg does each stage needs
wire ID_EX_Rs_EX_Fwd , ID_EX_Rt_EX_Fwd ;        // Output: EX take input from EX Fwd
wire ID_EX_Rs_MEM_Fwd , ID_EX_Rt_MEM_Fwd;       // Output: EX take input from MEM Fwd
wire EX_MEM_Rs_Fwd, EX_MEM_Rt_Fwd;              // Output: MEM take input from MEM Fwd
wire[3:0] EX_MEM_Opocode,     MEM_WB_Opocode;   // Input, the opocode of those two stage
wire EX_MEM_Opocode_Vld, MEM_WB_Opocode_Vld;    // Debug only, no need to connect. Whether the operation produce useful output in ALU.
                                                // If the operation is a load or save then the address is not useful.
// I/O end
assign MEM_WB_Opocode_Vld = MEM_WB_Opocode == 4'b1000;                                      //Only load lead to useful output
assign EX_MEM_Opocode_Vld = (EX_MEM_Opocode[3:1] != 3'b100)&(EX_MEM_Opocode[3:2]!= 2'b11);  //Not Store, Load, or Brunch, BR, PCS, HLT.

assign ID_EX_Rs_Fwd = (ID_EX_Rs!=0) & (EX_MEM_Rd == ID_EX_Rs) & (EX_MEM_Opocode_Vld);       //Rs EX to EX
assign ID_EX_Rt_Fwd = (ID_EX_Rt!=0) & (EX_MEM_Rd == ID_EX_Rt) & (EX_MEM_Opocode_Vld);       //Rt EX to EX
assign ID_EX_Rs_MEM_Fwd = (ID_EX_Rs!=0) & (MEM_WB_Rd == ID_EX_Rs) & (MEM_WB_Opocode_Vld);   //Rs Mem to EX
assign ID_EX_Rt_MEM_Fwd = (ID_EX_Rt!=0) & (MEM_WB_Rd == ID_EX_Rt) & (MEM_WB_Opocode_Vld);   //Rt Mem to EX
assign EX_MEM_Rs_Fwd = (EX_MEM_Rs!=0) & (MEM_WB_Rd == EX_MEM_Rs) & (MEM_WB_Opocode_Vld);    //Rs Mem to MEM
assign EX_MEM_Rt_Fwd = (EX_MEM_Rt!=0) & (MEM_WB_Rd == EX_MEM_Rt) & (MEM_WB_Opocode_Vld);    //Rs Mem to MEM


////////////////////////////////////////////
// HAZARD DETECTION //////////////////////// OK
////////////////////////////////////////////

// Detect load to use stall only!!! 
// The Stall Signal is passed to the ID/EX stage!!!
// I/O exposed
wire[3:0] ID_EX_opocode, EX_MEM_opocode;            // Input: Operation on each stage
wire[3:0] EX_MEM_RD;                                // Input: Load destination
wire[3:0] ID_EX_RS,ID_EX_RT;                        // Input: the regs that may need the newly loaded data
wire Stall;                                         // Output: whether the load-to-use stall is needed
// I/O End
wire ID_EX_RT_NOIMMEDIATA;                          // Whether RT is actually needed
wire ID_EX_RT_NOFORWARDING;                         // Whether RT can't be passed in later stage
assign ID_EX_RT_USED =                              // Not Shift related or PC related instruction
                ID_EX_opocode[3:2]!=2'b11 & !((ID_EX_opocode[3:2]==2'b01)&(ID_EX_opocode!=4'b0111));
assign ID_EX_RT_NOFORWARDING=
                ID_EX_opocode!= 4'b1001;            // if we are storing here, no stall need since we can get the data by forwarding.
assign Stall =  ((ID_EX_opocode == 4'b1100)|(ID_EX_opocode == 4'b1101))|// B or BR
                ((EX_MEM_opocode == 4'b1000)         // the memstage is storing
                &((ID_EX_RS == EX_MEM_RD)|((ID_EX_RT_NOFORWARDING & ID_EX_RT_USED)&
                (ID_EX_RT == EX_MEM_RD))));          // RT is actually used and no forwarding here.
endmodule