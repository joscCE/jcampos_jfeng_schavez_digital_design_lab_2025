module connect_four (
    input logic clk,        // Reloj de 50 MHz de la FPGA
    input logic rst, 
	 input [2:0] player0, player1, //[P,R,L]


    output logic Hs, Vs,
	 
	 
	 
	 output logic VGA_Blank, VGA_Sync_N, VGA_CLK, 
    output logic [7:0] R, G, B
);


    logic clk25;  // Reloj dividido a 25 MHz
	 logic rst_active;
	 logic [9:0] Q_X, Q_Y;
	 
	 
	 
	 assign rst_active = ~rst;
	 assign VGA_CLK = clk25;
	 
	 
	 
	 wire j_turn, select_turn, j_Column, Q_reg_Column; 
	 
	 
	 clk_div CLK25(
		.clk(clk),
		.rst_active(rst_active),
		.clk25(clk25)
	 
	 );
	 
	 
	 
	 //logica turno 
	 
	 Mux #(.N(3)) Mux_Player(
		.A(player1),
		.B(player0),
		.S(select_turn),
		.C(play)
	 
	 );
	 
	 //contador de turno
	 
	 Counter #(.N(1)) Count_Turn(
	 .clk(clk25),
    .rst(rst_turn | rst),
    .en(en_turn),
    .mode(1'b1),                
    .Q(j_turn)

	 
	 );
	 
	 
	 //registro del turno
	 
	 Register #(.N(1)) Reg_Turn(
	 .clk(clk25),
	 .rst(rst_turn | rst),
	 .D(j_turn),
	 .en(en_turn),
    .Q(select_turn)
	 
	
	 
	 );
	 
	 //logica columna \ parte jugada
	 
	 
	 Counter #(.N(3)) Count_Column(
	 .clk(clk25),
    .rst(rst),
    .en(en_count_column),
    .mode(mode_count_column),                
    .Q(j_Column)

	 
	 );
	 
	 
	 Register #(.N(3)) Reg_Column(
	 .clk(clk25),
	 .rst(rst),
	 .D(j_Column),
	 .en(en_count_column),
    .Q(Q_reg_Column)
	 
	 );
	 
	 
	 
	 Comparator #(.N(3)) Comp_Column_Right(
			.A(Q_reg_Column),
			.B(3'd7),
			.equ(comp_right)
	 
	 
	 );
	 
	 
	 
	 	 Comparator #(.N(3)) Comp_Column_Left(
			.A(Q_reg_Column),
			.B(3'h00),
			.equ(comp_left)
	 

	 );
	 
	 
	 
	 
	 
	 
	 
	 
	 //entradas
	 logic clk;
    logic rst;
	 logic [2:0] play; //[P,R,L]
    logic time_out;
    logic winning;
    logic valid_play;
    logic start;
    logic comp_turn;
    logic comp_right;
    logic comp_left;
    logic comp_random;
    logic p1, p0;

    // Salidas
    logic rst_timer;
    logic rst_turn;
    logic rst_game;
    logic rst_random;
    logic en_turn;
    logic en_count_column;
    logic en_random_play;
    logic en_new_game;
    logic en_reg_selection;
    logic mode_count_column;
    logic play_selection;
    logic [1:0] display_select;
	 
	 
	 
	 
	 
	 
	    FSM fsm_inst (
        .clk(clk25),
        .rst(rst),
        .L(play[0]),
        .R(play[1]),
		  .play(play[2]),
		  
        .time_out(time_out),
        .winning(winning),
        .valid_play(valid_play),
        .start(start),
        .comp_turn(comp_turn),
        .comp_right(comp_right),
        .comp_left(comp_left),
        .comp_random(comp_random),
        .p1(p1),
        .p0(p0),
        .rst_timer(rst_timer),
        .rst_turn(rst_turn),
        .rst_game(rst_game),
        .rst_random(rst_random),
        .en_turn(en_turn),
        .en_count_column(en_count_column),
        .en_random_play(en_random_play),
        .en_new_game(en_new_game),
        .en_reg_selection(en_reg_selection),
        .mode_count_column(mode_count_column),
        .play_selection(play_selection),
        .display_select(display_select)
    );

    
	 
	 
	 
	 
	 
	 
	 
//	 Game_Display GD (
//		.game(84'h00),
//		.column(3'h00),
//		.Q_X(Q_X),
//		.Q_Y(Q_Y),
//		.R(R),
//		.G(G), 
//		.B(B)
//		);
//		
//
//    // Instancia del controlador VGA
//    Vga_Controller vga_inst (
//        .clk(clk25),
//        .rst(rst_active),
//        .Hs(Hs),
//        .Vs(Vs),
//		  .VGA_Blank(VGA_Blank),
//		  .VGA_Sync_N(VGA_Sync_N),
//		  .Q_X(Q_X), 
//		  .Q_Y(Q_Y)
//    );

endmodule
