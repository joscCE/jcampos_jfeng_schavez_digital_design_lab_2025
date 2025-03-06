transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Problema_2/fulladderbit.vhd}
vcom -93 -work work {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Problema_2/Top_full_adder.vhd}

vcom -93 -work work {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Problema_2/tb_fulladderbit.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  tb_fulladderbit

add wave *
view structure
view signals
run -all
