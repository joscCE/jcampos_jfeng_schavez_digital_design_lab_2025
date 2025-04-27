transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Ayudapls/Documents/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/Ayudapls/Documents/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/Check_win.sv}
vlog -sv -work work +incdir+C:/Users/Ayudapls/Documents/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/Ayudapls/Documents/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/tb_Check_win.sv}

vlog -sv -work work +incdir+C:/Users/Ayudapls/Documents/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3 {C:/Users/Ayudapls/Documents/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_3/tb_Check_win.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_Check_win

add wave *
view structure
view signals
run -all
