onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/DUT/clk
add wave -noupdate /top_tb/DUT/rst_button_i
add wave -noupdate -expand /top_tb/DUT/leds_o
add wave -noupdate /top_tb/DUT/leds
add wave -noupdate /top_tb/DUT/r_CNT_1HZ
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9438365651 ps} 0}
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {10500 us}
