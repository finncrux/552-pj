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
wire PCWrite;

wire PC_Rd, PC_Wrt, Ovfl;
assign PC_Rd = 1'b1;
assign PC_Wrt = 1'b0;

//Stall Condition
assign PCWrite = Stall ? 0 : 1;

//PC Reg IN Select Mux
assign PC_Reg_IN = Branch_Hazard ? PC_Branch : PC_2;

//PC Reg
pc_reg pcreg(.rst(rst), .clk(clk), .PC_in(PC_Reg_IN), .PC_out(PC_Reg_OUT), .PCWrite(PCWrite & !hlt));

//PC Add 2
addsub_16bit PC_adder(.A(PC_Reg_OUT), .B(16'h0002), .Sum(PC_2), .sub(1'b0),.Ovfl(Ovfl));

//Instruction Memory
memory_I InstructionMem (.data_out(Instr_IF), .data_in(PC_Reg_OUT), .addr(PC_Reg_OUT), 
                            .enable(PC_Rd), .wr(PC_Wrt), .clk(clk), .rst(!rst_n));

////////////////////////////////////////////
// IF/ID Reg /////////////////////////////// OK
////////////////////////////////////////////

// I/O External
wire [15:0] PC_ID, Instr_ID;

// I/O Internal
wire IF_ID_Write;   //Set to 0 if stall
wire IF_Flush;      //Set to 1 if flush

assign IF_ID_Write = Stall ? 0 : 1;
assign IF_Flush = Flush;

// Data Reg
Register_16 PC(.D(PC_IF), .Q(PC_ID), .clk(clk), .rst(!rst_n), .wrtEn(IF_ID_Write));
Register_16 Instr(.D(Instr_IF), .Q(Instr_ID), .clk(clk), .rst(!rst_n || IF_Flush), .wrtEn(IF_ID_Write));


////////////////////////////////////////////
// ID //////////////////////////////////////
////////////////////////////////////////////

/////////////////to ID/EX register
wire [15:0] Rs_Data_ID, Rt_Data_ID, IMM_ID;
wire RegWrt_ID, MemWrt_ID, MemRead_ID, RegWrt_WB;
wire MemToReg_ID;  /////////////// load -> 0, other -> 1
wire [3:0] Rs_ID, Rt_ID, Rd_ID, ALUOp_ID, Rd_WB;
////////////////inside signal
wire [15:0] RegWrt_Data_WB;
wire [3:0]F;
wire [8:0]offset_9bit1;
wire writeReg1_en_ID, writeMem1_en_ID, MEM_DATA_RD_EN1_ID;
wire [3:0]OPCODE1;
wire Taken;
wire [2:0]C;
wire [15:0]PC_B, PC_BR;
wire ovfl, ovfl1;
wire [7:0]I;
wire halt_ID;
assign IF_Flush = Taken;
assign Taken = (C[2:0]==3'b000)?!F[2]:
               (C[2:0]==3'b001)?F[2]:
               (C[2:0]==3'b010)?(!F[2]&(!F[0])):
               (C[2:0]==3'b011)?F[0]:
               (C[2:0]==3'b100)?(F[2]|(!F[0]&(!F[2]))):
               (C[2:0]==3'b101)?((F[0]|(F[2]))):
               (C[2:0]==3'b110)?(F[1]):
               1'b1;
assign MemRead_ID = Stall? 1'b0 : (ALUOp_ID == 4'b1000);
assign MemToReg_ID = !(OPCODE1 == 4'b1000);
assign IMM_ID = {{8{I[7]}}, I};
assign MEM_DATA_RD_EN_ID = OPCODE1[3]&!OPCODE1[2]&!OPCODE1[1];
assign RegWrt_ID = Stall? 1'b0 : writeReg1_en_ID;
assign MemWrt_ID = Stall? 1'b0 : writeMem1_en_ID;
assign MEM_DATA_RD_EN_ID = Stall? 1'b0 : MEM_DATA_RD_EN1_ID;
assign ALUOp_ID = Stall? 1'b0 : OPCODE1;
assign PC_BR = Rs_Data_ID;
assign PC_Branch = Taken? (OPCODE1[0]? PC_B : PC_BR) : PC_IF;

addsub_16bit adder_B(.A(PC_IF), .B({{7{offset_9bit1[8]}}, offset_9bit1}), .sub(1'b0), .Sum(PC_B), .Ovfl(ovfl1));
decoder decoder(.instruction(Instr_IF), .opcode(OPCODE1), .rs(Rs_ID), .rt(Rt_ID), .rd(Rd_ID), 
                .immediate_8bit(I), .offset_9bit(offset_9bit1), .condition(C), .writem_en(writeMem1_en_ID),
                .writer_en(writeReg1_en_ID), .halt(halt_ID));

// register file
RegisterFile regfile(.clk(clk), .rst(!rst_n), .SrcReg1(Rs_ID), .SrcReg2(Rt_ID), .DstReg(Rd_WB), 
                        .WriteReg(RegWrt_WB), .DstData(RegWrt_Data_WB), 
                        .SrcData1(Rs_Data_ID), .SrcData2(Rt_Data_ID));






// I/O Expose



////////////////////////////////////////////
// ID/EX Reg /////////////////////////////// OK
////////////////////////////////////////////

// I/O Test
wire [15:0]  Instr_EX;
Register_16 Instr_id(.D(Instr_ID), .Q(Instr_EX), .clk(clk), .rst(!rst_n || IF_Flush), .wrtEn(IF_ID_Write));

// I/O Control
wire [3:0] ALUOp_EX;
wire ALUSrc_EX, RegDst_EX;      //EX
wire MemRead_EX, MemWrt_EX;     //M
wire MemToReg_EX, RegWrt_EX;    //WB
wire halt_EX;
// I/O Data
wire [15:0] Rs_Data_EX, Rt_Data_EX, IMM_EX;
wire [3:0] Rs_EX, Rt_EX, Rd_EX;

// Control Reg EX
Register_4 ALUOp(.D(ALUOp_ID), .Q(ALUOp_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 ALUSrc(.D(ALUSrc_ID), .Q(ALUSrc_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 RegDst(.D(RegDst_ID), .Q(RegDst_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 HALT_id(.D(halt_ID), .Q(halt_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Control Reg M
Register_1 MemRead_id(.D(MemRead_ID), .Q(MemRead_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 MemWrite_id(.D(MemWrt_ID), .Q(MemWrt_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Control Reg WB
Register_1 MemToReg_id(.D(MemToReg_ID), .Q(MemToReg_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 RegWrt_id(.D(RegWrt_ID), .Q(RegWrt_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Data Reg
Register_16 RegRead1(.D(Rs_Data_ID), .Q(Rs_Data_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_16 RegRead2(.D(Rt_Data_ID), .Q(Rt_Data_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_16 IMM(.D(IMM_ID), .Q(IMM_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

Register_4 Rs(.D(Rs_ID), .Q(Rs_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_4 Rt(.D(Rt_ID), .Q(Rt_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_4 Rd(.D(Rd_ID), .Q(Rd_EX), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));


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
wire [15:0] A,B,ExFWD_TEMP;
assign A = RsMemFwd?MemFwdSource:RsExFwd?ExFwdSource:Rs_Data_EX;
assign B = RtMemFwd?MemFwdSource:RtExFwd?ExFwdSource:RtExFwd;
assign MemFwdSource = RegWrt_Data_WB;
assign ExFwdSource = ExFWD_TEMP;
wire ALU_OVFL;
ALU alu(.A(A),.B(B),.I(IMM_EX[7:0]),.RES(RES_EX),.opocode(ALUOp_EX),.OVFL(ALU_OVFL));    
//wire [2:0] FlagFromAlu;     // flag output from ALU
//wire [15:0] MemFwdSource,ExFwdSource,Rs_Data_EX,Rt_data_EX;   // the data passed into ALU
//wire RsMemFwd,RsExFwd;      // RS forwarding?
//wire RtMemFwd,RtExFwd;      // Rt forwarding?
//wire [15:0] IMM;            // 16 bit immediate input



// Flag logic
assign FlagFromAlu = {(RES_EX==0),(ALU_OVFL),(RES_EX[15]==1)};
assign WriteEnableN =!(|ALUOp_EX[3:1]);
assign WriteEnableZ = WriteEnableN|(ALUOp_EX==4'b0010)|(ALUOp_EX==4'b0100)|(ALUOp_EX==4'b0101)|(ALUOp_EX==4'b0110);
assign WriteEnableV =!(|ALUOp_EX[3:1]);
Register_3 FLAGREG(.Q(FLAG),.D(FlagFromAlu),.clk(clk),.rst(!rst_n),.WriteEnableN(WriteEnableN),
                    .WriteEnableZ(WriteEnableZ),.WriteEnableV(WriteEnableV));

////////////////////////////////////////////
// EX/MEM Reg ////////////////////////////// OK
////////////////////////////////////////////

// I/O Test
wire [15:0]  Instr_MEM;
Register_16 Instr_ex(.D(Instr_EX), .Q(Instr_MEM), .clk(clk), .rst(!rst_n || IF_Flush), .wrtEn(IF_ID_Write));

//I/O Expose Control
wire [3:0] ALUOp_MEM;
wire ALUSrc_MEM, RegDst_MEM;    //EX
wire MemRead_MEM, MemWrt_MEM;   //M
wire MemToReg_MEM, RegWrt_MEM;  //WB
wire halt_MEM;
// I/O Expose Data
wire [15:0] MemWrt_Data_MEM, MemAddr_MEM;
wire [3:0] Rd_MEM, Rs_MEM;
assign ExFWD_TEMP = MemAddr_MEM;
// Control Reg EX
Register_4 ALUOp_ex(.D(ALUOp_EX), .Q(ALUOp_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 ALUSrc_ex(.D(ALUSrc_EX), .Q(ALUSrc_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 RegDst_ex(.D(RegDst_EX), .Q(RegDst_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Control Reg M
Register_1 MemRead_ex(.D(MemRead_EX), .Q(MemRead_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 MemWrite_ex(.D(MemWrt_EX), .Q(MemWrt_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Control Reg WB
Register_1 MemToReg_ex(.D(MemToReg_EX), .Q(MemToReg_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 RegWrt_ex(.D(RegWrt_EX), .Q(RegWrt_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 HALT_ex(.D(halt_EX), .Q(halt_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Data Reg
Register_16 RES_Reg(.D(RES_EX), .Q(MemAddr_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_16 B_Reg(.D(B), .Q(MemWrt_Data_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_4 Rd_ex(.D(Rd_EX), .Q(Rd_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_4 Rs_ex(.D(Rs_EX), .Q(Rs_MEM), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));


////////////////////////////////////////////
// MEM ///////////////////////////////////// OK
////////////////////////////////////////////

// I/O External
wire [15:0] MemRead_Data_MEM, MemWrt_Data;
wire MemFWD;
// Mem-Mem FWD MUX
assign MemWrt_Data = MemFWD ? RegWrt_Data_WB : MemWrt_Data_MEM;

// Data Memory
memory_D DataMemory(.data_out(MemRead_Data_MEM), .data_in(MemWrt_Data), .addr(MemAddr_MEM), 
                        .enable(MemRead_MEM), .wr(MemWrt_MEM), .clk(clk), .rst(!rst_n));








////////////////////////////////////////////
// MEM/WB Reg ////////////////////////////// OK
////////////////////////////////////////////

// I/O Test
wire [15:0]  Instr_WB, MemWrt_Data_WB;
Register_16 Instr_mem(.D(Instr_MEM), .Q(Instr_WB), .clk(clk), .rst(!rst_n || IF_Flush), .wrtEn(IF_ID_Write));
Register_16 MemWrt_Data_mem(.D(MemWrt_Data), .Q(MemWrt_Data_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

//I/O Expose Control
wire [3:0] ALUOp_WB;
wire ALUSrc_WB, RegDst_WB;    //EX
wire MemRead_WB, MemWrt_WB;   //M
wire MemToReg_WB;  //WB
wire halt_WB;
// I/O Expose Data
wire [15:0] MemRead_Data_WB, MemAddr_WB;

// Control Reg EX
Register_4 ALUOp_mem(.D(ALUOp_MEM), .Q(ALUOp_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 ALUSrc_mem(.D(ALUSrc_MEM), .Q(ALUSrc_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 RegDst_mem(.D(RegDst_MEM), .Q(RegDst_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Control Reg M
Register_1 MemRead_mem(.D(MemRead_MEM), .Q(MemRead_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 MemWrite_mem(.D(MemWrt_MEM), .Q(MemWrt_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Control Reg WB
Register_1 MemToReg_mem(.D(MemToReg_MEM), .Q(MemToReg_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 RegWrt_mem(.D(RegWrt_MEM), .Q(RegWrt_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_1 HALT_mem(.D(halt_MEM), .Q(halt_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));

// Data Reg
Register_16 MemRead_Data(.D(MemRead_Data_MEM), .Q(MemRead_Data_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_16 MemAddr(.D(MemAddr_MEM), .Q(MemAddr_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));
Register_4 Rd_mem(.D(Rd_MEM), .Q(Rd_WB), .clk(clk), .rst(!rst_n), .wrtEn(wrtEn_1));


////////////////////////////////////////////
// WB ////////////////////////////////////// OK
////////////////////////////////////////////

// I/O External
//wire [15:0] RegWrt_Data_WB;
assign hlt = halt_WB;
//Select RegWrt Data
assign RegWrt_Data_WB = MemToReg_WB ? MemRead_Data_WB : MemAddr_WB;






////////////////////////////////////////////
// FORWARDING UNIT ///////////////////////// OK
////////////////////////////////////////////

FWDunit fwd(.EX_MEM_Opocode(ALUOp_EX),.MEM_WB_Opocode(ALUOp_WB),
           .ID_EX_Rs(Rs_EX),  .ID_EX_Rt(Rt_EX),                 
           .EX_MEM_Rd(Rd_MEM), 
           .MEM_WB_Rd(Rd_WB), 
           .ID_EX_Rs_EX_Fwd(RsExFwd) , .ID_EX_Rt_EX_Fwd(RtExFwd) ,
           .ID_EX_Rs_MEM_Fwd(RsMemFwd) , .ID_EX_Rt_MEM_Fwd(RtMemFwd),
           .MEM_TO_MEM_Fwd(MemFWD));

////////////////////////////////////////////
// HAZARD DETECTION //////////////////////// OK
////////////////////////////////////////////

// Detect load to use stall only!!! 
// The Stall Signal is passed to the ID/EX stage!!!
// I/O exposed
wire[3:0] ID_EX_opocode, EX_MEM_opocode;            // Input: Operation on each stage
wire[3:0] EX_MEM_RD;                                // Input: Load destination
wire[3:0] ID_EX_RS,ID_EX_RT;                        // Input: the regs that may need the newly loaded data
// I/O End
wire ID_EX_RT_NOIMMEDIATA;                          // Whether RT is actually needed
wire ID_EX_RT_NOFORWARDING;                         // Whether RT can't be passed in later stage
assign ID_EX_RT_USED =                              // Not Shift related or PC related instruction
                ID_EX_opocode[3:2]!=2'b11 & !((ID_EX_opocode[3:2]==2'b01)&(ID_EX_opocode!=4'b0111));
assign ID_EX_RT_NOFORWARDING=
                ID_EX_opocode!= 4'b1001;            // if we are storing here, no stall 
                                                    // need since we can get the data by forwarding.
assign Stall =  ((ID_EX_opocode == 4'b1100)|(ID_EX_opocode == 4'b1101))|// B or BR
                ((EX_MEM_opocode == 4'b1000)         // the memstage is storing
                &((ID_EX_RS == EX_MEM_RD)|((ID_EX_RT_NOFORWARDING & ID_EX_RT_USED)&
                (ID_EX_RT == EX_MEM_RD))));          // RT is actually used and no forwarding here.
endmodule