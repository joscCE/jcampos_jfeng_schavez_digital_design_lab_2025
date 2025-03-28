transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra/decoderBDC.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra/Decoder7seg.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra/Top_Controller.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra/fulladderbit.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra/Decoder_prob1.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra/Adder_prob3.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra/deco_prob3.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra/Sub_prob3.sv}
vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra/deco_sub3.sv}

vlog -sv -work work +incdir+C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra {C:/Users/josee/joscCE_JimF04_Sebas36762_digital_design_lab_2025/Lab_1/Extra/Top_Controller_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  Top_Controller_tb

add wave *
view structure
view signals
run -all
