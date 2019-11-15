module PC_control(C,I,F,PC_in,PC_out);
input [2:0] C;
input [8:0] I;
input [2:0] F;
input [15:0] PC_in;
output [15:0] PC_out;
wire Taken,ovfl1,ovfl2;
wire [15:0] IncedPC,IncedPCWithImm;
wire [15:0]pci_B = {6'b000000,I,1'b0};
assign Taken = (C[2:0]==3'b000)?!F[2]:
               (C[2:0]==3'b001)?F[2]:
               (C[2:0]==3'b010)?(!F[2]&(!F[0])):
               (C[2:0]==3'b011)?F[0]:
               (C[2:0]==3'b100)?(F[2]|(!F[0]&(!F[2]))):
               (C[2:0]==3'b101)?((F[0]|(F[2]))):
               (C[2:0]==3'b110)?(F[1]):
               1'b1;

addsub_16bit PC_adder(.A(PC_in), .B(16'h0002), .Sum(IncedPC), .sub(1'b0),.Ovfl(ovfl1));
addsub_16bit PC_I_adder(.A(IncedPC), .B(pci_B), .Sum(IncedPCWithImm), .sub(1'b0),.Ovfl(ovfl2));
assign PC_out[15:0] = Taken?IncedPCWithImm[15:0]:IncedPC[15:0];
endmodule