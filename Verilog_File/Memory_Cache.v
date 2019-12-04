module Memory_Cache(clk,rst_n,Write,Read,DataIn,DataOut,Stall,Addr);
input       clk,rst_n;
input       Write;
input       Read;
input[15:0] Addr;
input[7:0]  DataIn;
output[7:0] DataOut;
output      Stall;

wire        rst;
wire        fsm_busy;
wire        miss_detected;
wire        write_data_array;
wire        write_tag_array;
wire        memory_data_valid;
wire[15:0]  miss_address;
wire[15:0]  memory_address;
wire[15:0]  memory_data;
assign rst = !rst_n;

////////////////////////////////////////
// MetaDataArray and wires
////////////////////////////////////////
wire MetaDataArray_WR;          // write enable for metadata
wire[7:0]   MetaDataArray_IN;   // write value to metadata
wire[7:0]   MetadataArray_OUT;  // read avlue from metadata
wire[127:0] MetaDataArray_EN;   // onehot, which block to be read or write

MetaDataArray Metadata1(.clk(clk), .rst(rst_n), .DataIn(MetaDataArray_IN), .Write(MetaDataArray_WR),
 .BlockEnable(MetaDataArray_EN), .DataOut(MetadataArray_OUT));

////////////////////////////////////////
// DataArray and wires
////////////////////////////////////////
wire        DataArray_WR;      // enable for w
wire[15:0]  DataArray_IN;      // data input
wire[15:0]  DataArray_OUT;     // data read out
wire[127:0] DataArray_EN;      // enable for r/w. one hot
wire[7:0]   DataArray_ADDR;    // 128 block address available in total
DataArray Data(.clk(clk), .rst(rst_n), .DataIn(DataArray_IN), 
.Write(DataArray_WR), .BlockEnable(BlockEnable), .WordEnable(DataArray_ADDR), .DataOut(DataArray_OUT));

/////////////////////////////////////////
// Multicycle Memroy
/////////////////////////////////////////
wire        Memory_WR;
wire        Memory_EN;
wire        Memroy_VLD;
wire[15:0]  Memory_IN;
wire[15:0]  Memory_OUT;
wire[15:0]  Memroy_ADDR;

memory4c Memory (.data_out(Memory_OUT), .data_in(Memory_IN), .addr(Memroy_ADDR), 
.enable(Memory_EN), .wr(Memory_WR), .clk(clk), .rst(rst_n), .data_valid(Memroy_VLD));


//////////////////////////////////////////
// FSM
//////////////////////////////////////////

// step 0: if is doing load/store operation, go to step 1.

// step 1: start stalling. Use 2 cycles, check 2 metadata block and determine 
// if the cache hit, go to step 3, 
// if the cache miss, determine which metadata block should be replaced or filled. 
// setting up the destination of memory reading.
// goto step 2.

// step 2: Start issueing reading for 8 cycles(0 - 7). 
//         Getting data back for 8 cycles (4 - 12).
//         Writing to the dataArray for 8 cycles (4 - 12).
//         Update the vld bit and TAG value for the newly read block. (0).
// goto step 3.

// step 3: 
//         Update two metadata blocks LRU bit.(0 - 1).
//         If read, get the data(2 Byte) from DataArray. (0).
//         If write, write the data(2 Byte) to the DataArray.   (0).
//         If write, write the data(2 Byte) to the main memory. (0 - 1).
// goto step final

// step final: un-stalling.

endmodule