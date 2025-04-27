module Mouse_Controller(
    input PS2_CLK,
    input PS2_DAT,
    output loigc [19:0] Mouse_Coords

);

//entrada y salidas de la FSM

    logic BO,
    logic B1,
    logic B2,
    logic Byte_Out,
    logic Bit_Out,
    logic sig_x,
    logic sig_y,
    logic clk,
    logic rst,  
    logic rst_Bit_Counter,
    logic rst_Byte_Counter,
    
    logic en_Bit_Counter,
    logic en_Byte_Counter,

    logic en_Reg_Status,
    logic en_Reg_DX,
    logic en_Reg_DY,
    logic shft_Status,
    logic shft_DX,
    logic shft_DY,
    logic en_Sumandor,
    logic mode_sum_X,
    logic mode_sum_y,
    logic [7:0] Q_Reg_Status, Q_Reg_DY,Q_Reg_DX,
    logic [3:0] Q_Counter_Bit,
    logic [1:0] Q_Counter_Byte,
    logic eq_Comp_Byte_0,eq_Comp_Byte_1,eq_Comp_Byte_2,eq_Comp_Byte_3, eq_Comp_Bite

//shif registers


Shift_Reg #(.N(8)) Reg_shift_status (
    .clk(PS2_CLK) 
    .rst(rst),
	.D(PS2_DAT),
	.en(en_Reg_Status),
    .shf(shft_Status),
	.Q(Q_Reg_Status)

);

Shift_Reg #(.N(8)) Reg_shift_DX(
  .clk(PS2_CLK) 
    .rst(rst),
	.D(PS2_DAT),
	.en(en_Reg_DX),
    .shf(shft_DX),
	.Q(Q_Reg_DX)

);

Shift_Reg #(.N(8))Reg_shift_DY(
  .clk(PS2_CLK) 
    .rst(rst),
	.D(PS2_DAT),
	.en(en_Reg_DY),
    .shf(shft_DY),
	.Q(Q_Reg_DY)

);

//counters


Counter #(.N(2)) Byte_Counter (
.clk(PS2_CLK)
.rst(rst_Byte_Counter),
.en(en_Byte_Counter),
.mode(1'b1),                
.Q(Q_Counter_Byte)

);



Counter #(.N(4))Bit_Counter(
.clk(PS2_CLK)
.rst(rst_Bit_Counter),
.en(en_Bit_Counter),
.mode(1'b1),                
.Q(Q_Counter_Bit)
);


//comparator

Comparador #(N.(2)) Byte_Comparator_0(    
	A(Q_Counter_Byte), 
    B(1'b0),
	equ(eq_Comp_Byte_0)

);


Comparador #(N.(2)) Byte_Comparator_1(    
	A(Q_Counter_Byte), 
    B(1'b1),
	equ(eq_Comp_Byte_1)

);

Comparador #(N.(2)) Byte_Comparator_2(    
	A(Q_Counter_Byte), 
    B(2'b10),
	equ(eq_Comp_Byte_2)

);

Comparador #(.N(2))Byte_Comparator_3(    
	A(Q_Counter_Byte), 
    B(2'b11),
	equ(eq_Comp_Byte_3)

);

Comparador #(.N(4)) Bit_Comparator(    
	A(Q_Counter_Bit), 
    B(4'b1000),
	equ(eq_Comp_Bite)

);

//Adders

Adder #(.N(16)) Sum_X (
    .A(Q_Reg_X_pos),
    .en(en_Sumandor),
    .Mode(mode_sum_X),
    .B(Q_Reg_DX),
    .C(D_Red_X_Pos),
    

);


Adder #(.N(16)) Sum_Y (
    .A(Q_Reg_Y_pos),
    .en(en_Sumandor),
    .Mode(mode_sum_y),
    .B(Q_Reg_DY),
    .C(D_Red_Y_Pos),

);

//registros de la posicion

Register #(.N(16)) Reg_X_Pos(
    .clk(PS2_CLK) 
    .rst(rst),
	.D(D_Red_X_Pos),
	.en(en_Reg_X_pos),
	.Q(Q_Reg_X_pos),


);

Register #(.N(16))Reg_Y_Pos(
    .clk(PS2_CLK) 
    .rst(rst),
	.D(D_Red_Y_Pos),
	.en(en_Reg_Y_pos),
	.Q(Q_Reg_Y_pos),

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
    .shft_Status(Reg_shift_status),
    .shft_DX(Reg_shift_DX),
    .shft_DY(Reg_shift_DY),
    .en_Sumandor(en_Sumandor),
    .mode_sum_X(mode_sum_X),
    .mode_sum_y(mode_sum_y),
    .en_Reg_Y_pos(en_Reg_Y_pos),
    .en_Reg_X_pos(en_Reg_X_pos)
);


assign Mouse_Coords = {Q_Reg_X_pos, Q_Reg_Y_pos}; // si quieres juntar X e Y


endmodule

