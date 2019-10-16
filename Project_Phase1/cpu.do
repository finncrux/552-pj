onerror {resume}
quietly virtual signal -install /cpu_tb/DUT/regfile/R1 { (context /cpu_tb/DUT/regfile/R1 )&{Cell0/Q , Cell1/Q , Cell2/Q , Cell3/Q , Cell4/Q , Cell5/Q , Cell6/Q , Cell7/Q , Cell8/Q , Cell9/Q , Cell10/Q , Cell11/Q , Cell12/Q , Cell13/Q , Cell14/Q , Cell15/Q }} r1
quietly virtual signal -install /cpu_tb/DUT/regfile/R1 { (context /cpu_tb/DUT/regfile/R1 )&{Cell15/Q , Cell14/Q , Cell13/Q , Cell12/Q , Cell11/Q , Cell10/Q , Cell9/Q , Cell8/Q , Cell7/Q , Cell6/Q , Cell5/Q , Cell4/Q , Cell3/Q , Cell2/Q , Cell1/Q , Cell0/Q }} R1
quietly virtual signal -install /cpu_tb/DUT/regfile/R2 { (context /cpu_tb/DUT/regfile/R2 )&{Cell15/Q , Cell14/Q , Cell13/Q , Cell12/Q , Cell11/Q , Cell10/Q , Cell9/Q , Cell8/Q , Cell7/Q , Cell6/Q , Cell5/Q , Cell4/Q , Cell3/Q , Cell2/Q , Cell1/Q , Cell0/Q }} R2
quietly virtual signal -install /cpu_tb/DUT/regfile/R3 { (context /cpu_tb/DUT/regfile/R3 )&{Cell15/Q , Cell14/Q , Cell13/Q , Cell12/Q , Cell11/Q , Cell10/Q , Cell9/Q , Cell8/Q , Cell7/Q , Cell6/Q , Cell5/Q , Cell4/Q , Cell3/Q , Cell2/Q , Cell1/Q , Cell0/Q }} R3
quietly virtual signal -install /cpu_tb/DUT/regfile/R0 { (context /cpu_tb/DUT/regfile/R0 )&{Cell15/Q , Cell14/Q , Cell13/Q , Cell12/Q , Cell11/Q , Cell10/Q , Cell9/Q , Cell8/Q , Cell7/Q , Cell6/Q , Cell5/Q , Cell4/Q , Cell3/Q , Cell2/Q , Cell1/Q , Cell0/Q }} R0
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /cpu_tb/PC
add wave -noupdate -radix unsigned /cpu_tb/Inst
add wave -noupdate /cpu_tb/RegWrite
add wave -noupdate -radix unsigned /cpu_tb/WriteRegister
add wave -noupdate -radix decimal /cpu_tb/WriteData
add wave -noupdate /cpu_tb/MemWrite
add wave -noupdate /cpu_tb/MemRead
add wave -noupdate -radix unsigned /cpu_tb/MemAddress
add wave -noupdate -radix decimal /cpu_tb/MemData
add wave -noupdate /cpu_tb/Halt
add wave -noupdate /cpu_tb/inst_count
add wave -noupdate /cpu_tb/cycle_count
add wave -noupdate /cpu_tb/trace_file
add wave -noupdate /cpu_tb/sim_log_file
add wave -noupdate /cpu_tb/clk
add wave -noupdate /cpu_tb/rst_n
add wave -noupdate -divider R
add wave -noupdate -radix hexadecimal /cpu_tb/DUT/regfile/R0/R0
add wave -noupdate -radix hexadecimal -childformat {{{/cpu_tb/DUT/regfile/R1/R1[15]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[14]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[13]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[12]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[11]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[10]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[9]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[8]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[7]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[6]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[5]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[4]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[3]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[2]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[1]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R1/R1[0]} -radix hexadecimal}} -subitemconfig {/cpu_tb/DUT/regfile/R1/Cell15/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell14/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell13/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell12/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell11/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell10/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell9/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell8/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell7/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell6/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell5/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell4/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell3/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell2/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell1/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R1/Cell0/Q {-radix hexadecimal}} /cpu_tb/DUT/regfile/R1/R1
add wave -noupdate -radix hexadecimal -childformat {{{/cpu_tb/DUT/regfile/R2/R2[15]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[14]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[13]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[12]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[11]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[10]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[9]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[8]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[7]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[6]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[5]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[4]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[3]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[2]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[1]} -radix hexadecimal} {{/cpu_tb/DUT/regfile/R2/R2[0]} -radix hexadecimal}} -subitemconfig {/cpu_tb/DUT/regfile/R2/Cell15/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell14/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell13/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell12/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell11/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell10/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell9/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell8/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell7/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell6/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell5/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell4/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell3/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell2/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell1/Q {-radix hexadecimal} /cpu_tb/DUT/regfile/R2/Cell0/Q {-radix hexadecimal}} /cpu_tb/DUT/regfile/R2/R2
add wave -noupdate -radix hexadecimal /cpu_tb/DUT/regfile/R3/R3
add wave -noupdate -divider ALU
add wave -noupdate /cpu_tb/DUT/alu/opocode
add wave -noupdate -radix hexadecimal /cpu_tb/DUT/alu/A
add wave -noupdate -radix hexadecimal /cpu_tb/DUT/alu/B
add wave -noupdate -radix hexadecimal /cpu_tb/DUT/alu/I
add wave -noupdate -radix hexadecimal /cpu_tb/DUT/alu/RES
add wave -noupdate /cpu_tb/DUT/alu/OVFL
add wave -noupdate /cpu_tb/DUT/alu/result_ADDSUB
add wave -noupdate /cpu_tb/DUT/alu/result_PADDSB
add wave -noupdate /cpu_tb/DUT/alu/result_RED
add wave -noupdate /cpu_tb/DUT/alu/result_SHIFTER
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {737 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 244
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {164 ps} {1360 ps}
