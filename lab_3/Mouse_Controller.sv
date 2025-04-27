module Mouse_Controller(
    input PS2_CLK,
    input PS2_DAT,
	 input rst,
    output logic [15:0] Mouse_CoordsX,
	 output logic [15:0] Mouse_CoordsY,
	 output logic [2:0] debug_state,
	 
	 output logic [3:0] debug_bit_counter,
	 output logic [1:0] debug_byte_counter,
	 output logic [7:0] debug_status, debug_dx, debug_dy

);

//entrada y salidas de la FSM

    logic BO;
    logic B1;
    logic B2;
    logic Byte_Out;
    logic Bit_Out;
    logic sig_x;
    logic sig_y;
    logic clk;
    logic rst_Bit_Counter;
    logic rst_Byte_Counter;
    
    logic en_Bit_Counter;
    logic en_Byte_Counter;

    logic en_Reg_Status;
    logic en_Reg_DX;
    logic en_Reg_DY;
    logic shft_Status;
    logic shft_DX;
    logic shft_DY;
    logic en_Sumandor;
    logic mode_sum_X;
    logic mode_sum_y;
    logic [7:0] Q_Reg_Status, Q_Reg_DY,Q_Reg_DX;
    logic [3:0] Q_Counter_Bit;
    logic [1:0] Q_Counter_Byte;
    logic eq_Comp_Byte_0,eq_Comp_Byte_1,eq_Comp_Byte_2,eq_Comp_Byte_3, eq_Comp_Bite;
	 logic [15:0] Q_Reg_X_pos, Q_Reg_Y_pos;
	logic [15:0] D_Red_X_Pos, D_Red_Y_Pos;
	logic en_Reg_X_pos, en_Reg_Y_pos;
	 
	 
	 //shif registers


Shift_Reg #(.N(8)) Reg_shift_status (
    .clk(PS2_CLK),
    .rst(rst),
	.D(PS2_DAT),
	.en(en_Reg_Status),
    .shf(shft_Status),
	.Q(Q_Reg_Status)

);

Shift_Reg #(.N(8)) Reg_shift_DX(
  .clk(PS2_CLK),
    .rst(rst),
	.D(PS2_DAT),
	.en(en_Reg_DX),
    .shf(shft_DX),
	.Q(Q_Reg_DX)

);

Shift_Reg #(.N(8))Reg_shift_DY(
  .clk(PS2_CLK), 
    .rst(rst),
	.D(PS2_DAT),
	.en(en_Reg_DY),
    .shf(shft_DY),
	.Q(Q_Reg_DY)

);

//counters


Counter #(.N(2)) Byte_Counter (
.clk(PS2_CLK),
.rst(rst_Byte_Counter | rst),
.en(en_Byte_Counter),
.mode(1'b1),                
.Q(Q_Counter_Byte)

);



Counter #(.N(4))Bit_Counter(
.clk(PS2_CLK),
.rst(rst_Bit_Counter | rst),
.en(en_Bit_Counter),
.mode(1'b1),                
.Q(Q_Counter_Bit)
);


//comparator

Comparator #(.N(2)) Byte_Comparator_0(    
	.A(Q_Counter_Byte), 
    .B(2'b00),
	.equ(eq_Comp_Byte_0)

);


Comparator #(.N(2)) Byte_Comparator_1(    
	.A(Q_Counter_Byte), 
    .B(2'b01),
	.equ(eq_Comp_Byte_1)

);

Comparator #(.N(2)) Byte_Comparator_2(    
	.A(Q_Counter_Byte), 
    .B(2'b10),
	.equ(eq_Comp_Byte_2)

);

Comparator #(.N(2))Byte_Comparator_3(    
	.A(Q_Counter_Byte), 
    .B(2'b11),
	.equ(eq_Comp_Byte_3)

);

Comparator #(.N(4)) Bit_Comparator(    
	.A(Q_Counter_Bit), 
    .B(4'b1000),
	.equ(eq_Comp_Bite)

);

//Adders

Adder #(.N(16)) Sum_X (
    .A(Q_Reg_X_pos),
    .en(en_Sumandor),
    .Mode(mode_sum_X),
    .B({8'h00,Q_Reg_DX}),
    .C(D_Red_X_Pos)
    

);


Adder #(.N(16)) Sum_Y (
    .A(Q_Reg_Y_pos),
    .en(en_Sumandor),
    .Mode(mode_sum_y),
    .B({8'h00,Q_Reg_DX}),
    .C(D_Red_Y_Pos)

);

//registros de la posicion

Register #(.N(16)) Reg_X_Pos(
    .clk(PS2_CLK),
    .rst(rst),
	.D(D_Red_X_Pos),
	.en(en_Reg_X_pos),
	.Q(Q_Reg_X_pos)


);

Register #(.N(16))Reg_Y_Pos(
    .clk(PS2_CLK), 
    .rst(rst),
	.D(D_Red_Y_Pos),
	.en(en_Reg_Y_pos),
	.Q(Q_Reg_Y_pos)

);

//FSM

FSM_Mouse FSM_M (
    .BO(eq_Comp_Byte_0),
    .B1(eq_Comp_Byte_1),
    .B2(eq_Comp_Byte_2),
    .Byte_Out(eq_Comp_Byte_3),
    .Bit_Out(eq_Comp_Bite),
    .sig_x(Q_Reg_Status[3]),
    .sig_y(Q_Reg_Status[2]),
    .clk(PS2_CLK),
    .rst(rst),  
    .rst_Bit_Counter(rst_Bit_Counter),
    .rst_Byte_Counter(rst_Byte_Counter),
    .en_Reg_Status(en_Reg_Status),
    .en_Reg_DX(en_Reg_DX),
    .en_Reg_DY(en_Reg_DY),
    .shft_Status(shft_Status),
    .shft_DX(shft_DX),
    .shft_DY(shft_DY),
    .en_Sumandor(en_Sumandor),
    .mode_sum_X(mode_sum_X),
    .mode_sum_y(mode_sum_y),
    .en_Reg_Y_pos(en_Reg_Y_pos),
    .en_Reg_X_pos(en_Reg_X_pos),
	 .debug_state(debug_state),
	 .en_Bit_Counter(en_Bit_Counter),
    .en_Byte_Counter(en_Byte_Counter)
	 
	 
);


assign Mouse_CoordsX = Q_Reg_X_pos; 
assign Mouse_CoordsY = Q_Reg_Y_pos; 
assign debug_bit_counter = Q_Counter_Bit;
assign debug_byte_counter = Q_Counter_Byte;
assign debug_status = Q_Reg_Status;
assign debug_dx = Q_Reg_DX;
assign debug_dy = Q_Reg_DY;

endmodule

