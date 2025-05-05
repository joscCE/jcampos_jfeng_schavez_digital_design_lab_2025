module Mouse_Controller(
    inout  PS2_CLK,
    input clk,
    inout  PS2_DAT,
		input rst,
		output logic [2:0] debug_state,
    output logic [33:0] debug_data,
	 output debug_clk_in,
	 output [9:0] Q_write_debug,
	 output [9:0] Q_T_debug

);

logic clk_oe;
logic data_oe;

assign PS2_CLK = clk_oe? 1'b0:1'bZ;
assign PS2_DAT = data_oe? ps2_dat_out:1'bZ;


logic  ps2_dat_out;
logic clk_div;

clk_div_custom clkcos (
    .clk(clk),         // clk de 50MHz
    .rst(rst),         // reset
    .clk_out(clk_div)      // clk de ~12.5kHz
);

logic ps2_clk_falling;    
logic ps2_clk_in;         
logic ps2_dat_in;

PS2_Synchronizer  PS2_Syc(
    .de(data_oe),
    .ce(clk_oe),
    .clk(clk_div),           
    .PS2_CLK(PS2_CLK),       
    .PS2_DAT(PS2_DAT),       
    .ps2_clk_falling(ps2_clk_falling), 
    .ps2_clk_in(ps2_clk_in),      
    .ps2_dat_in(ps2_dat_in)       
);

assign debug_clk_in = ps2_clk_in;


//logica para ver si hay que escribir al mouse en el estado 0

logic [7:0] Q_count_start;
logic Start_Write;
logic rst_Counter_start;

Counter #(.N(8)) Count_Start(
    .clk(clk_div),
    .rst(~(&{ps2_clk_in, ps2_dat_in})),
    .en({ps2_clk_in,ps2_dat_in} == 2'b11),
    .mode(1'b1),                
    .Q(Q_count_start)

);

Comparator #(.N(8)) Comp_Start(
    
	.A(Q_count_start), 
    .B(8'b1111111),
	.equ(Start_Write)
);

// logica de hold_time para el estado 1
logic [17:0] Q_count_Hold_time;
logic Hold_Time;
logic rst_Count_Hold_Time;
logic en_Count_Hold_Time;

Counter #(.N(18)) Count_Hold_Time(
    .clk(clk_div),
    .rst(rst_Count_Hold_Time),
    .en(en_Count_Hold_Time),
    .mode(1'b1),                
    .Q(Q_count_Hold_time)
);


Comparator #(.N(18)) Comp_hold_time(
	.A(Q_count_Hold_time), 
    .B(18'd2),
	.equ(Hold_Time)
);




//logica para mandar mensaje
logic en_reg_out;
logic shift_reg_out;
logic rs_Count_write;
logic en_Count_write;
logic [3:0] Q_count_write;
logic wo;


Reg_Shift_Out #(.N(10)) reg_escritura (
    .clk(ps2_clk_in),
    .rst(rst),
    .D(10'b1001011110),
    .en(en_reg_out),
    .shf(shift_reg_out),
    .Q(ps2_dat_out),
    .Q_T(Q_T_debug)
);



Counter #(.N(4)) Count_write(
    .clk(ps2_clk_in),
    .rst(rs_Count_write | rst),
    .en(en_Count_write),
    .mode(1'b1),                
    .Q(Q_count_write)
);


Comparator #(.N(4)) Comp_write(
	.A(Q_count_write), 
    .B(4'b1001),
	.equ(wo)
);

Shift_Reg #(.N(10)) reg_wirte_debug(
	.clk(ps2_clk_in), 
   .rst(rst | rs_Count_write),
	.D(ps2_dat_in),
	.en(en_Count_write),
   .shf(shift_reg_out),
	.Q(Q_write_debug)
);

assign debug_data = Q_reg_lectura;



 

//logica para recibir datos

logic en_reg_lectura;
logic shif_reg_lectura; 
logic [32:0] Q_reg_lectura;

Shift_Reg #(.N(33)) reg_lectura(
	.clk(ps2_clk_in), 
    .rst(rst),
	.D(ps2_dat_in),
	.en(en_reg_lectura),
    .shf(shif_reg_lectura),
	.Q(Q_reg_lectura)
);

assign debug_data = Q_reg_lectura;


FSM_Mouse FMS_MO(
	.clk(clk_div),
	.rst(rst),
    .Start_Write(Start_Write),
    .Hold_Time(Hold_Time),
    .wo(wo),
    .en_reg_out(en_reg_out),
    .clk_oe(clk_oe),
    .data_oe(data_oe),
    .en_reg_lectura(en_reg_lectura),
    .shif_reg_lectura(shif_reg_lectura),
    .shift_reg_out(shift_reg_out),
    .rs_Count_write(rs_Count_write),
    .en_Count_write(en_Count_write),
    .rst_Count_Hold_Time(rst_Count_Hold_Time),
    .en_Count_Hold_Time(en_Count_Hold_Time),
    .debug_state(debug_state),
	 .rst_Counter_start(rst_Counter_start)
    

);



endmodule

