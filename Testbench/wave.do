onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider CPU_tb
add wave -noupdate /cpu_ptb/RegWrite
add wave -noupdate -color Gold -radix hexadecimal -radixshowbase 0 /cpu_ptb/WriteData
add wave -noupdate /cpu_ptb/WriteRegister
add wave -noupdate /cpu_ptb/Halt
add wave -noupdate /cpu_ptb/Inst
add wave -noupdate /cpu_ptb/MemAddress
add wave -noupdate /cpu_ptb/MemDataIn
add wave -noupdate /cpu_ptb/MemDataOut
add wave -noupdate /cpu_ptb/MemRead
add wave -noupdate /cpu_ptb/MemWrite
add wave -noupdate -radix decimal -radixshowbase 0 /cpu_ptb/PC
add wave -noupdate /cpu_ptb/clk
add wave -noupdate -radix unsigned -radixshowbase 0 /cpu_ptb/cycle_count
add wave -noupdate -radix decimal -radixshowbase 0 /cpu_ptb/inst_count
add wave -noupdate /cpu_ptb/rst_n
add wave -noupdate -radix binary /cpu_ptb/DUT/ALUOp_ID
add wave -noupdate -radix binary /cpu_ptb/DUT/ALUOp_EX
add wave -noupdate -radix binary /cpu_ptb/DUT/ALUOp_MEM
add wave -noupdate -radix binary /cpu_ptb/DUT/ALUOp_WB
add wave -noupdate -divider REGWRITE
add wave -noupdate /cpu_ptb/DUT/RegWrt_ID
add wave -noupdate /cpu_ptb/DUT/RegWrt_EX
add wave -noupdate /cpu_ptb/DUT/RegWrt_MEM
add wave -noupdate /cpu_ptb/DUT/RegWrt_WB
add wave -noupdate -divider OPCODE
add wave -noupdate -radix binary /cpu_ptb/DUT/ALUOp_ID
add wave -noupdate -radix binary /cpu_ptb/DUT/ALUOp_EX
add wave -noupdate -radix binary /cpu_ptb/DUT/ALUOp_MEM
add wave -noupdate -radix binary /cpu_ptb/DUT/ALUOp_WB
add wave -noupdate -divider CPU_Internal
add wave -noupdate /cpu_ptb/DUT/IF_Flush
add wave -noupdate /cpu_ptb/DUT/Stall
add wave -noupdate -divider PC
add wave -noupdate -radix decimal -radixshowbase 0 /cpu_ptb/DUT/PC_Reg_OUT
add wave -noupdate -radix decimal /cpu_ptb/DUT/PC_Reg_IN
add wave -noupdate /cpu_ptb/DUT/Branch_Hazard
add wave -noupdate /cpu_ptb/DUT/PC_Branch
add wave -noupdate /cpu_ptb/DUT/F
add wave -noupdate /cpu_ptb/DUT/C
add wave -noupdate /cpu_ptb/DUT/Instr_IF
add wave -noupdate /cpu_ptb/DUT/PC_Wrt
add wave -noupdate /cpu_ptb/DUT/PCWrite
add wave -noupdate /cpu_ptb/DUT/Taken
add wave -noupdate /cpu_ptb/DUT/Branch
add wave -noupdate -radix decimal /cpu_ptb/DUT/PC_B
add wave -noupdate /cpu_ptb/DUT/PC_BR
add wave -noupdate -divider ID
add wave -noupdate /cpu_ptb/DUT/Instr_ID
add wave -noupdate /cpu_ptb/DUT/Rt_ID
add wave -noupdate /cpu_ptb/DUT/Rs_ID
add wave -noupdate /cpu_ptb/DUT/Rd_ID
add wave -noupdate -divider EX
add wave -noupdate -radix hexadecimal /cpu_ptb/DUT/A
add wave -noupdate -radix hexadecimal /cpu_ptb/DUT/B
add wave -noupdate -divider FWDING
add wave -noupdate /cpu_ptb/DUT/fwd/ID_EX_Rs_EX_Fwd
add wave -noupdate /cpu_ptb/DUT/fwd/ID_EX_Rt_EX_Fwd
add wave -noupdate /cpu_ptb/DUT/fwd/ID_EX_Rs_MEM_Fwd
add wave -noupdate /cpu_ptb/DUT/fwd/ID_EX_Rt_MEM_Fwd
add wave -noupdate /cpu_ptb/DUT/fwd/MEM_TO_MEM_Fwd
add wave -noupdate /cpu_ptb/DUT/fwd/EX_MEM_Opocode_Vld
add wave -noupdate /cpu_ptb/DUT/RES_EX
add wave -noupdate /cpu_ptb/DUT/fwd/EX_MEM_Opocode
add wave -noupdate /cpu_ptb/DUT/fwd/EX_MEM_Rd
add wave -noupdate /cpu_ptb/DUT/fwd/ID_EX_Rs
add wave -noupdate /cpu_ptb/DUT/fwd/ID_EX_Rt
add wave -noupdate /cpu_ptb/DUT/fwd/MEM_TO_MEM_Opocode_Vld
add wave -noupdate /cpu_ptb/DUT/fwd/MEM_WB_Opocode
add wave -noupdate /cpu_ptb/DUT/fwd/MEM_WB_Opocode_Vld
add wave -noupdate /cpu_ptb/DUT/fwd/MEM_WB_Rd
add wave -noupdate -divider ADDER_PC
add wave -noupdate /cpu_ptb/DUT/adder_B/A
add wave -noupdate /cpu_ptb/DUT/adder_B/B
add wave -noupdate /cpu_ptb/DUT/adder_B/B_in
add wave -noupdate /cpu_ptb/DUT/adder_B/Cout
add wave -noupdate /cpu_ptb/DUT/adder_B/Ovfl
add wave -noupdate /cpu_ptb/DUT/adder_B/S
add wave -noupdate /cpu_ptb/DUT/adder_B/Sum
add wave -noupdate /cpu_ptb/DUT/Branch_Hazard
add wave -noupdate -divider MEM_CACHE
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Addr_mem_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/D_Data_in
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/D_Data_out
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/D_addr_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/D_d_en_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/D_data_in_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/D_md_en_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/D_miss
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Data_addr
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Data_out_mem
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/IDLE_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/I_Data_out
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/I_addr
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/I_addr_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/I_d_en_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/I_data_in_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/I_md_en_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/I_miss
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/R
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Stall
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/W
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/clk
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/data_valid_m
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/enable_mem_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/opcode
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/rst
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/rst_n
add wave -noupdate -divider CACHE_I
add wave -noupdate -divider LEFT_META
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/BlockEnable
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/DataIn
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/DataOut
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/Write
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/clk
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/rst
add wave -noupdate -divider LeftData
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/DATA_cache/Left_D/BlockEnable
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/DATA_cache/Left_D/DataIn
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/DATA_cache/Left_D/DataOut
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/DATA_cache/Left_D/WordEnable
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/DATA_cache/Left_D/Write
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/DATA_cache/Left_D/clk
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/DATA_cache/Left_D/rst
add wave -noupdate -divider MCELL
add wave -noupdate {/cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/Mblk[127]/mc[0]/Din}
add wave -noupdate {/cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/Mblk[127]/mc[0]/Dout}
add wave -noupdate {/cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/Mblk[127]/mc[0]/Enable}
add wave -noupdate {/cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/Mblk[127]/mc[0]/WriteEnable}
add wave -noupdate {/cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/Mblk[127]/mc[0]/clk}
add wave -noupdate {/cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/Mblk[127]/mc[0]/q}
add wave -noupdate {/cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M/Mblk[127]/mc[0]/rst}
add wave -noupdate -divider MEMORY_4C
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/ADDR_WIDTH
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/addr
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/clk
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/data_in
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/data_out
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/data_valid
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/data_valid_1
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/data_valid_2
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/data_valid_3
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/data_valid_4
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/enable
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/loaded
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/mem
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/rst
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Memory/wr
add wave -noupdate -divider FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/state
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/Addr_C
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/Addr_D
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/Addr_I
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/Addr_M
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/Addr_Miss_D
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/Addr_Miss_I
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/DataArray_WE_D
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/DataArray_WE_I
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/DataIn_M
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/DataOut_D
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/DataOut_I
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/DataVLD
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/Data_WE
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/EN_M
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/IDLE
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/IDLE_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/MetaDataArray_WE_D
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/MetaDataArray_WE_I
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/MetaData_WE
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/Miss_D
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/Miss_I
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/R
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/Stall
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/W
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/WAIT_D
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/WAIT_I
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/addr
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/addr_after
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/addr_after2
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/addr_after3
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/addr_after4
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/addr_inc
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/clk
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/cnt
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/cnt_after
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/cntr_full
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/cntr_half
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/cntr_inc
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/cntr_rst
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/nxt_state
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/ovfl1
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/ovfl2
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/rst
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/rst_n
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Control/state
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Addr_CPU
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Addr_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/BLOCK_EN
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/DataIn_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/DataOut_CPU
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Data_WE
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/GoLeft
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Hit
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Hit_Left
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Hit_Right
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_D_BE
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_D_IN
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_D_OUT
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_D_WE
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_D_WORD
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_LRU
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M_BE
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M_IN
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M_OUT
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M_REG_OUT
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M_WE_IN
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_M_WE_OUT
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_TAG_RD
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Left_VLD
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/MetaData_WE
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Miss
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/OFFSET
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/OFFSET_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/R
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_D_BE
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_D_IN
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_D_OUT
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_D_WE
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_D_WORD
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_LRU
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_M_BE
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_M_IN
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_M_OUT
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_M_REG_OUT
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_M_WE_IN
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_M_WE_OUT
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_TAG_RD
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/Right_VLD
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/SET
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/TAG
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/WORD_SEL
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/WORD_SEL_FSM
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/clk
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/rst
add wave -noupdate /cpu_ptb/DUT/MEM_CACHE/Inst_cache/rst_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1485 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 245
configure wave -valuecolwidth 191
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1189 ns}
