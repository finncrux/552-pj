module Shifter (Shift_Out, Shift_In, Shift_Val, Mode);
input [15:0] Shift_In; 	// This is the input data to perform shift operation on
input [3:0] Shift_Val; 	// Shift amount (used to shift the input data)
input  Mode; 		// To indicate 0=SLL or 1=SRA 
output [15:0] Shift_Out; 	// Shifted output data
wire[15:0] stg1,stg2,stg3;

assign stg1 = Shift_Val[0]?Mode? {Shift_In[15],Shift_In[15:1]}:{Shift_In[14:0],1'b0}:Shift_In;
assign stg2 = Shift_Val[1]?Mode? {{2{stg1[15]}},stg1[15:2]}:{stg1[13:0],2'b0}:stg1 ;
assign stg3 = Shift_Val[2]?Mode? {{4{stg2[15]}},stg2[15:4]}:{stg2[11:0],4'b0}:stg2;
assign Shift_Out = Shift_Val[3]? Mode? {{8{stg3[15]}},stg3[15:8]}:{stg3[7:0],8'b0}:stg3;


endmodule


