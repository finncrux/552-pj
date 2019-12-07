module Memory_Cache(clk,rst_n,I_addr, I_Data_out, opcode, D_Data_in, Data_addr, D_Data_out, Stall);
input           clk,rst_n;
input [3:0]     opcode;
input [15:0]    I_addr, Data_addr, D_Data_in;
output[15:0]    I_Data_out, D_Data_out;
output          Stall;

wire        rst, W, R;
assign rst = !rst_n;
assign W = opcode == 4'b1001;
assign R = opcode == 4'b1000;
wire [15:0]     D_data_in_FSM,I_data_in_FSM, D_addr_FSM, I_addr_FSM, Data_out_mem;
wire [15:0]     Addr_mem_FSM;
wire            D_miss, I_miss, D_md_en_FSM, I_md_en_FSM, D_d_en_FSM, I_d_en_FSM,stall_D,stall_I;
wire            stall_cache;
assign          stall_cache = stall_D | stall_I;
wire            data_valid_m, enable_mem_FSM, IDLE_FSM;
Cache_D DATA_cache(.clk(clk), .rst_n(rst_n), .DataIn_FSM(D_data_in_FSM), .DataIn_CPU(D_Data_in), .DataOut_CPU(D_Data_out), .Miss(D_miss),
                    .Addr_CPU(Data_addr), .Addr_FSM(D_addr_FSM), .MetaData_WE(D_md_en_FSM), .Data_WE(D_d_en_FSM) , .R(R), .W(W),
                    .stall_D(stall_D));

Cache_I Inst_cache(.clk(clk), .rst_n(rst_n), .DataIn_FSM(I_data_in_FSM), .DataOut_CPU(I_Data_out), .Miss(I_miss), .Addr_CPU(I_addr),
                    .Addr_FSM(I_addr_FSM), .MetaData_WE(I_md_en_FSM), .Data_WE(I_d_en_FSM),.stall_I(stall_I));


memory4c Memory   (.data_out(Data_out_mem), .data_in(D_Data_in), .addr((W&IDLE_FSM)?Data_addr:Addr_mem_FSM), .enable(enable_mem_FSM | (W&IDLE_FSM)), .wr(IDLE_FSM & W), .clk(clk), .rst(rst), .data_valid(data_valid_m));

Cache_Ctrl Control(.DataOut_I(I_data_in_FSM), .DataArray_WE_I(I_d_en_FSM), .MetaDataArray_WE_I(I_md_en_FSM), .Miss_I(I_miss), .Addr_I(I_addr), 
                .Addr_Miss_I(I_addr_FSM), .DataOut_D(D_data_in_FSM), .DataArray_WE_D(D_d_en_FSM), .MetaDataArray_WE_D(D_md_en_FSM), .Miss_D(D_miss), .Addr_D(Data_addr), 
                .Addr_Miss_D(D_addr_FSM), .DataVLD(data_valid_m), .Addr_M(Addr_mem_FSM),.IDLE_FSM(IDLE_FSM), .EN_M(enable_mem_FSM), .clk(clk), .rst(rst), .Stall(Stall),
                .R(R),.W(W),.DataIn_M(Data_out_mem),.stall_cache(stall_cache));

endmodule