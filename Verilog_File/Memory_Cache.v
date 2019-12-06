module Memory_Cache(clk,rst_n,I_addr, I_Data_out, opcode, D_Data_in, Data_addr, D_Data_out, Stall);
input       clk,rst_n;
input       Write;
input       Read;
input[15:0] I_Addr, Data_addr;
input[7:0]  DataIn;
output[7:0] DataOut;
output      Stall;

wire        rst;
wire        miss_detected;
wire        write_data_array;
wire        write_tag_array;
wire        memory_data_valid;
wire[15:0]  miss_address;
wire[15:0]  memory_address;
wire[15:0]  memory_data;
assign rst = !rst_n;

Cache_D DATA_cache(.clk(clk),.rst_n(rst_n),DataIn_FSM,DataIn_CPU,DataOut_CPU,Miss,
                    Addr_CPU,Addr_FSM,MetaData_WE,Data_WE,R,W);
Cache_I Inst_cache(.clk(clk),rst_n,DataIn_FSM,DataOut_CPU,Miss,Addr_CPU,
                    Addr_FSM,MetaData_WE,Data_WE,R);
memory4c Memory   (data_out, data_in, addr, enable, wr, clk, rst, data_valid);

Cache_Ctrl Control(DataIn_I, DataOut_I, DataArray_WE_I, MetaDataArray_WE_I, Miss_I, Addr_I, IF
                    DataIn_D, DataOut_D, DataArray_WE_D, MetaDataArray_WE_D, Miss_D, Addr_D, R, W, 
                    DataIn_M, DataOut_M, DataVLD, Addr_M, WE_M, clk, rst, Stall);

endmodule