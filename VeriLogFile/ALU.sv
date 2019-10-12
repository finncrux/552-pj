module ALU (ALU_Out, Error, ALU_In1, ALU_In2, Opcode);
input [3:0] ALU_In1, ALU_In2;
input [1:0] Opcode; 
output  [3:0] ALU_Out;
output Error;                           // Just to show overflow
wire[3:0] output0,output2,output3;      // output of different operation
wire Ovfl;      
assign Error = Ovfl&~(Opcode[1]);       // calculate the Error condition
assign output2 = ~(ALU_In1&ALU_In2);    // calculate NAND
assign output3 = ALU_In1^ALU_In2;       // calculate XOR
addsub_4bit Addsub(.A(ALU_In1),.B(ALU_In2),.Sum(output0),.sub(Opcode[0]),.Ovfl(Ovfl));// the add-sub module
                                        // select the correct output
assign ALU_Out = (Opcode == 2'b00)?output0:
                 (Opcode == 2'b01)?output0:
                 (Opcode == 2'b10)?output2:
                 output3;
endmodule

