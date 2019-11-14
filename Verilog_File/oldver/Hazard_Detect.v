module Hazard_Detect(Stall, ID_EX_opocode, EX_MEM_opocode, EX_MEM_RD, ID_EX_RS,ID_EX_RT);
// Detect load to use stall only!!! 
// The Stall Signal is passed to the ID/EX stage!!!
// I/O exposed
Input [3:0] ID_EX_opocode, EX_MEM_opocode;            // Input: Operation on each stage
Input [3:0] EX_MEM_RD;                                // Input: Load destination
Input [3:0] ID_EX_RS,ID_EX_RT;                        // Input: the regs that may need the newly loaded data
Output Stall;                                         // Output: whether the load-to-use stall is needed
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