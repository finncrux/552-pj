module ALU_tb();
wire[3:0] out,OUT1,OUT2,OUT3,OUT0;
reg [3:0] in1,in2;
reg [1:0] opcode;
wire error,ERROR;
wire VLD;
assign OUT0 = in1+in2;
assign OUT1 = in1-in2;
assign OUT2 = ~(in1&in2);
assign OUT3 = (in1^in2);
assign ERROR = ~opcode[1]&(opcode[0]? ((!in1[3])&(in2[3])&(out[3]))|((in1[3])&(!in2[3])&(!out[3])):
((in1[3])&(in2[3])&(!out[3]))|((!in1[3])&(!in2[3])&(out[3])));

ALU Alu(.ALU_Out(out), .Error(error), .ALU_In1(in1), .ALU_In2(in2), .Opcode(opcode));
assign VLD = 
(opcode == 0)? (out == OUT0)&(error == ERROR): 
(opcode == 1)? (out == OUT1)&(error == ERROR): 
(opcode == 2)? (out == OUT2): 
(opcode == 3)? (out == OUT3): 1;

initial
begin
   #5
    in1 = 1;
    in2 = -8;
    opcode = 1;
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0);
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0);
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0);
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0);
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0);
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0);
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0); 
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0);
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0);
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0); 
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0);
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0);
  #5
    in1 = $urandom_range(12,-12);
    in2 = $urandom_range(12,-12);
    opcode = $urandom_range(3,0); 
end
endmodule
