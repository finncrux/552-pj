module Cache_Ctrl(DataOut_I, DataArray_WE_I, MetaDataArray_WE_I, Miss_I, Addr_I, Addr_Miss_I,
                    DataOut_D, DataArray_WE_D, MetaDataArray_WE_D, Miss_D, Addr_D, Addr_Miss_D, R, W, 
                    DataIn_M, DataVLD, Addr_M, EN_M, clk, rst, Stall, IDLE_FSM,stall_cache,Idle_DontWrt);

//////////////////////////////////////////
// Ports
//////////////////////////////////////////
input    stall_cache;
input   [15:0]  Addr_I;
input           Miss_I;
output  [15:0]  DataOut_I;
output  [15:0]  Addr_Miss_I;
output          DataArray_WE_I;
output          MetaDataArray_WE_I;
input   [15:0]  Addr_D;
input           Miss_D;
input           R, W;
output  [15:0]  DataOut_D;
output  [15:0]  Addr_Miss_D;
output          DataArray_WE_D;
output          MetaDataArray_WE_D;
output          Idle_DontWrt;
input   [15:0]  DataIn_M;
input            DataVLD;
output  [15:0]  Addr_M;
output  reg     EN_M;           //Ctrl
output  reg     IDLE_FSM;       //Ctrl
output  reg     Stall;          //Ctrl
input           clk, rst;

wire Data_VLD,cntr_lt4;
wire rst_n;
assign rst_n = !rst;
// Next State Flop
wire [1:0] state;
reg  [1:0] nxt_state;
//////////////////////////////////////////
// address computation
//////////////////////////////////////////

//ADDR_M
// External Wire
reg addr_inc, addr_rst,addr_I_rst,addr_D_rst;
//External Signal
reg Data_WE, MetaData_WE;
// Internal Wire
wire [15:0] addr_after, addr, Addr_C;
wire[15:0] addr_base_I,addr_base_D;
assign addr_base_I = {{Addr_I[15:4]},{4'h0}};
assign addr_base_D = {{Addr_D[15:4]},{4'h0}};

wire [15:0] addr_out;
assign addr_after = (addr_D_rst|addr_I_rst) ? (addr_I_rst? addr_base_I : addr_base_D) : addr_out;
addsub_16bit Addr_adder_M(.A(addr), .B(16'h2), .sub(1'b0), .Sum(addr_out), .Ovfl( ));
addsub_16bit Addr_adder_C(.A(addr), .B(16'h8), .sub(1'b1), .Sum(Addr_C), .Ovfl( ));
Register_16 Addr_reg1(.Q(addr), .D(addr_after), .clk(clk), .rst(!rst_n), .wrtEn(addr_inc));
/*
Register_16 Addr_reg2(.Q(addr_after2), .D(addr), .clk(clk), .rst(!rst_n|addr_rst), .wrtEn(addr_inc));
Register_16 Addr_reg3(.Q(addr_after3), .D(addr_after2), .clk(clk), .rst(!rst_n|addr_rst), .wrtEn(addr_inc));
Register_16 Addr_reg4(.Q(addr_after4), .D(addr_after3), .clk(clk), .rst(!rst_n|addr_rst), .wrtEn(addr_inc));
Register_16 Addr_reg5(.Q(Addr_C), .D(addr_after4), .clk(clk), .rst(!rst_n|addr_rst), .wrtEn(addr_inc));*/


//////////////////////////////////////////
// Cntr
//////////////////////////////////////////

// External Wire
reg  cntr_rst, cntr_inc;
wire cntr_full,cntr_half;
// Internal Wire
wire[3:0]   cnt, cnt_after;
assign cntr_full = cnt == 4'b0111;
assign cntr_half = (cnt == 4'b0011) | (cnt == 4'b0000) | (cnt == 4'b0001) | (cnt == 4'b0010);
wire[3:0] cnt2;
wire[3:0] cnt2_after;
reg       cntr2_rst;
assign cntr_lt4 = ((cnt2 == 4'h0)|(cnt2 == 4'h1)|(cnt2 == 4'h2)|(cnt2 == 4'h3));
assign Data_VLD = DataVLD & !cntr_lt4;

Register_4 current_block(.Q(cnt), .D(cnt_after), .clk(clk), .rst(!rst_n | cntr_rst), .wrtEn(cntr_inc));
Register_4 current_clk  (.Q(cnt2), .D(cnt2_after), .clk(clk), .rst(!rst_n | cntr2_rst), .wrtEn(1'b1));

CLA_4bit blocks8(.A(cntr_rst? 4'b0000 : cnt), .B({3'b000,!cntr_full}), 
                    .Cin(1'b0), .S(cnt_after), .G( ), .P( ), .Ovfl( ), .Cout( ));

CLA_4bit blocks9(.A(cntr2_rst? 4'b0000 : cnt2), .B(4'h1), 
                    .Cin(1'b0), .S(cnt2_after), .G( ), .P( ), .Ovfl( ), .Cout( ));

//////////////////////////////////////////
// FSM
//////////////////////////////////////////

// Params
localparam IDLE   = 2'b00;
localparam WAIT_I = 2'b01;
localparam WAIT_D = 2'b10;
localparam WAIT_WB= 2'b11;

reg  Idle_NOWRT;
dff_2 FSM_state(.D(nxt_state), .Q(state), .WE(1'b1), .clk(clk), .rst(rst));
Register_1  reg1(.Q(Idle_DontWrt),.D(Idle_NOWRT),.clk(clk),.rst(rst),.wrtEn(1'b1));

// Next State Combination Logic
always@(*) begin
    Idle_NOWRT = 0;
    nxt_state = IDLE;
    addr_I_rst = 0;
    addr_D_rst = 0;
    Stall = 1'b0;
    EN_M = 1'b0;
    cntr_inc = 1'b0;
    addr_inc = 1'b0;
    Data_WE = 1'b0;
    MetaData_WE = 1'b0;
    IDLE_FSM = 1'b0;
    cntr_rst = 0;
    cntr2_rst = 0;
    case(state)
        IDLE: begin
            IDLE_FSM = 1'b1;
            Idle_NOWRT = 0;
            nxt_state = stall_cache ? WAIT_WB : 
                        Miss_I ? WAIT_I : 
                        (!Miss_I&Miss_D) ? WAIT_D : IDLE;
            Stall = Miss_I | Miss_D | stall_cache;
            cntr_rst = 1;
            //addr_rst = 1;
            addr_I_rst = !(!Miss_I&Miss_D);
            addr_D_rst = 1;
            addr_inc = Miss_I | Miss_D;
            EN_M = W;
            cntr2_rst = 1;
        end

        WAIT_I: begin
            nxt_state = (!Miss_D&cntr_full) ? WAIT_WB :
                        (Miss_D&cntr_full)  ? WAIT_D : WAIT_I;
            Stall = 1'b1;
            EN_M = cntr_half;
            cntr_rst  = (Miss_D&cntr_full);
            cntr2_rst = (Miss_D&cntr_full);
            addr_D_rst = (Miss_D&cntr_full);
            //addr_rst = (Miss_D&cntr_full);
            cntr_inc = DataVLD;
            addr_inc = 1'b1;
            Data_WE = DataVLD&(!cntr_lt4);
            MetaData_WE = cntr_full;
        end

        WAIT_D: begin // WAIT_D
            nxt_state = cntr_full ? WAIT_WB : WAIT_D;
            Stall = 1'b1;
            EN_M = cntr_half;
            cntr_inc = DataVLD;
            addr_inc = 1'b1;
            Data_WE = DataVLD&(!cntr_lt4);
            MetaData_WE = cntr_full;
        end

        WAIT_WB : begin
            nxt_state = IDLE;
            Stall = 1'b1;
            Idle_NOWRT = 0;
        end
    endcase

end

//////////////////////////////////////////
// Cntr
//////////////////////////////////////////



// Cache_I
assign DataOut_I = (state == WAIT_I) ? DataIn_M : 16'h0000;
assign Addr_Miss_I = (state == WAIT_I) ? Addr_C : 16'h0000;
assign DataArray_WE_I = (state == WAIT_I) ? Data_WE : 0;
assign MetaDataArray_WE_I = (state == WAIT_I) ? MetaData_WE : 0;

// Cache_D
assign DataOut_D = (state == WAIT_D) ? DataIn_M : 16'h0000;
assign Addr_Miss_D = (state == WAIT_D) ? Addr_C : 16'h0000;
assign DataArray_WE_D = (state == WAIT_D) ? Data_WE : 0;
assign MetaDataArray_WE_D = (state == WAIT_D) ? MetaData_WE : 0;

// Mem4C
assign Addr_M = addr;








endmodule