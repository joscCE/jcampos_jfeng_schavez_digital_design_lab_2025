transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/FSM.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/Counter.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/Vga_Controller.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/connect_four.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/Register.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/Comparator.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/Write_Play.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/Game_Display.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/Mux.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/Check_win.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/clk_div.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/debounce.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/Mux_31.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/display_menu.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/Start_B_ROM.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/output_files {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/output_files/Piece_ROM.sv}

vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/tb_Mouse_Controller.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_Mouse_Controller

add wave *
view structure
view signals
run -all
