transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/jimmy/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_2/problema_1 {C:/Users/jimmy/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_2/problema_1/top_sub.sv}
vlog -sv -work work +incdir+C:/Users/jimmy/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_2/problema_1 {C:/Users/jimmy/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_2/problema_1/Top_Calc.sv}
vlog -sv -work work +incdir+C:/Users/jimmy/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_2/problema_1 {C:/Users/jimmy/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_2/problema_1/Multiplier.sv}
vlog -sv -work work +incdir+C:/Users/jimmy/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_2/problema_1 {C:/Users/jimmy/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_2/problema_1/fulladderbit.sv}
vlog -sv -work work +incdir+C:/Users/jimmy/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_2/problema_1 {C:/Users/jimmy/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_2/problema_1/FullAdder.sv}

vlog -sv -work work +incdir+C:/Users/jimmy/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_2/problema_1 {C:/Users/jimmy/GitHub/joscCE_JimF04_Sebas36762_digital_design_lab_2025/lab_2/problema_1/tb_top_sub.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_top_sub

add wave *
view structure
view signals
run -all
