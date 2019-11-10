////////////////////////////////////////////
// FORWARDING UNIT /////////////////////////
////////////////////////////////////////////

// I/O exposed
// How to read?
// e.g ID_EX_Rs_MEM_Fwd means in ID/EX stage, Rs take forwarding input from MEM stage
module FWDunit(EX_MEM_Opocode,MEM_WB_Opocode,
           ID_EX_Rs,  ID_EX_Rt,                 
           EX_MEM_Rd, 
           MEM_WB_Rd, 
          ID_EX_Rs_EX_Fwd , ID_EX_Rt_EX_Fwd ,
          ID_EX_Rs_MEM_Fwd , ID_EX_Rt_MEM_Fwd,
          MEM_TO_MEM_Fwd);
input [3:0]  
           ID_EX_Rs,  ID_EX_Rt,                 
           EX_MEM_Rd, 
           MEM_WB_Rd;     // Input: which reg does each stage needs
output  ID_EX_Rs_EX_Fwd , ID_EX_Rt_EX_Fwd ;       // Output: EX take input from EX Fwd
output ID_EX_Rs_MEM_Fwd , ID_EX_Rt_MEM_Fwd;       // Output: EX take input from MEM Fwd
output MEM_TO_MEM_Fwd;                            // Output: MEM take input from MEM Fwd
input [3:0] EX_MEM_Opocode,     MEM_WB_Opocode;   // Input, the opocode of those two stage
wire EX_MEM_Opocode_Vld, MEM_WB_Opocode_Vld;    // Debug only, no need to connect. Whether the operation produce useful output in ALU.
                                                // If the operation is a load or save then the address is not useful.
// I/O end
assign MEM_WB_Opocode_Vld = MEM_WB_Opocode == 4'b1000;                                      //Only load lead to useful output
assign EX_MEM_Opocode_Vld = (EX_MEM_Opocode[3:1] != 3'b100)&(EX_MEM_Opocode[3:2]!= 2'b11);  //Not Store, Load, or Brunch, BR, PCS, HLT.

assign ID_EX_Rs_Fwd = (ID_EX_Rs!=0) & (EX_MEM_Rd == ID_EX_Rs) & (EX_MEM_Opocode_Vld);       //Rs EX to EX
assign ID_EX_Rt_Fwd = (ID_EX_Rt!=0) & (EX_MEM_Rd == ID_EX_Rt) & (EX_MEM_Opocode_Vld);       //Rt EX to EX
assign ID_EX_Rs_MEM_Fwd = (ID_EX_Rs!=0) & (MEM_WB_Rd == ID_EX_Rs) & (MEM_WB_Opocode_Vld);   //Rs Mem to EX
assign ID_EX_Rt_MEM_Fwd = (ID_EX_Rt!=0) & (MEM_WB_Rd == ID_EX_Rt) & (MEM_WB_Opocode_Vld);   //Rt Mem to EX
assign EX_MEM_Rs_Fwd = (EX_MEM_Rd!=0) & (MEM_WB_Rd == EX_MEM_Rd) & (MEM_WB_Opocode_Vld);    //Rs Mem to MEM

endmodule
