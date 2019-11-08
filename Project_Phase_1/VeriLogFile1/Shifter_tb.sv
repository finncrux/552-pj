module Shifter_tb();
reg signed[15:0]Input;
reg[3:0] shiftval;
reg mode;
wire[15:0] SHIFT_OUT, shift_out;
wire VLD;
Shifter SFT(.Shift_Out(shift_out), .Shift_In(Input), .Shift_Val(shiftval), .Mode(mode));
assign SHIFT_OUT = mode? Input>>>shiftval:Input<< shiftval;
assign VLD = (shift_out == SHIFT_OUT);

initial begin
    #5
    Input = $urandom_range(65536,-65536);
    mode = $urandom_range(1,0);
    shiftval = $urandom_range(15,0);
    #5
    Input = $urandom_range(65536,-65536);
    mode = $urandom_range(1,0);
    shiftval = $urandom_range(15,0);
    #5
    Input = $urandom_range(65536,-65536);
    mode = $urandom_range(1,0);
    shiftval = $urandom_range(15,0);
    #5
    Input = $urandom_range(65536,-65536);
    mode = $urandom_range(1,0);
    shiftval = $urandom_range(15,0);
    #5
    Input = $urandom_range(65536,-65536);
    mode = $urandom_range(1,0);
    shiftval = $urandom_range(15,0);
    #5
    Input = $urandom_range(65536,-65536);
    mode = $urandom_range(1,0);
    shiftval = $urandom_range(15,0);
    #5
    Input = $urandom_range(65536,-65536);
    mode = $urandom_range(1,0);
    shiftval = $urandom_range(15,0);
    #5
    Input = $urandom_range(65536,-65536);
    mode = $urandom_range(1,0);
    shiftval = $urandom_range(15,0);
    #5
    Input = $urandom_range(65536,-65536);
    mode = $urandom_range(1,0);
    shiftval = $urandom_range(15,0);
    #5
    Input = $urandom_range(65536,-65536);
    mode = $urandom_range(1,0);
    shiftval = $urandom_range(15,0);

end



endmodule

