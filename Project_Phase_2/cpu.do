onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider CPU_tb
add wave -noupdate /cpu_ptb/Halt
add wave -noupdate /cpu_ptb/Inst
add wave -noupdate /cpu_ptb/MemAddress
add wave -noupdate /cpu_ptb/MemDataIn
add wave -noupdate /cpu_ptb/MemDataOut
add wave -noupdate /cpu_ptb/MemRead
add wave -noupdate /cpu_ptb/MemWrite
add wave -noupdate /cpu_ptb/PC
add wave -noupdate /cpu_ptb/RegWrite
add wave -noupdate /cpu_ptb/WriteData
add wave -noupdate /cpu_ptb/WriteRegister
add wave -noupdate /cpu_ptb/clk
add wave -noupdate -radix unsigned -radixshowbase 0 /cpu_ptb/cycle_count
add wave -noupdate -radix decimal -radixshowbase 0 /cpu_ptb/inst_count
add wave -noupdate /cpu_ptb/rst_n
add wave -noupdate /cpu_ptb/sim_log_file
add wave -noupdate /cpu_ptb/trace_file
add wave -noupdate -divider CPU_Internal
add wave -noupdate /cpu_ptb/DUT/IF_Flush
add wave -noupdate /cpu_ptb/DUT/Stall
add wave -noupdate -divider PC
add wave -noupdate /cpu_ptb/DUT/PC_Reg_OUT
add wave -noupdate /cpu_ptb/DUT/Taken
add wave -noupdate /cpu_ptb/DUT/Branch
add wave -noupdate /cpu_ptb/DUT/F
add wave -noupdate /cpu_ptb/DUT/C
add wave -noupdate /cpu_ptb/DUT/Instr_IF
add wave -noupdate -divider ID
add wave -noupdate /cpu_ptb/DUT/Instr_ID
add wave -noupdate /cpu_ptb/DUT/Rt_ID
add wave -noupdate /cpu_ptb/DUT/Rs_ID
add wave -noupdate /cpu_ptb/DUT/Rd_ID
add wave -noupdate -divider EX
add wave -noupdate /cpu_ptb/DUT/A
add wave -noupdate /cpu_ptb/DUT/B
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {394 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {1282 ns}
