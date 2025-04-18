module connect_four (
    input logic clk,        // Reloj de 50 MHz de la FPGA
    input logic rstin, 
	 input [2:0] player0in, player1in, //[P,R,L]
	 input p0in, p1in,
	 input startin,

    output logic Hs, Vs,
	 
	 output logic VGA_Blank, VGA_Sync_N, VGA_CLK, 
    output logic [7:0] R, G, B,
	 output logic [2:0] debug_colum
	 
	 
	 
);

    logic clk25;  // Reloj dividido a 25 MHz
	 logic rst;
	 logic [2:0] player0;
	 logic [2:0] player1;
	 
	 
	 logic p0, p1, start;
	 
	 
	 logic [9:0] Q_X, Q_Y;
	 
	 
	 assign rst = ~rstin;
	 assign player0 = ~player0in;
	 assign player1 = ~player1in;
	 assign p0 = ~p0in;
	 assign p1 = ~p1in;
	 assign start = ~startin;
	 
	 
	 assign VGA_CLK = clk25;
	 
	 
	 
	 
    logic [27:0] Q_reg_count_time;  // Asumiendo que es un contador de 28 bits (por comparación con 28'd250_000_000)
    logic [2:0] j_count_random;
    logic [2:0] Q_reg_random;
    logic [4:0] Q_reg_Play;
    logic Q_Reg_Select_Move;
    logic [4:0] c_Mux_Play;

	
	
	 	 //entradas
	 logic [2:0] play; //[P,R,L]
    logic time_out;
    logic winning;
    logic valid_play;
    logic comp_turn;
    logic comp_right;
    logic comp_left;
    logic comp_random;

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
	 logic [2:0] Q_reg_Column;
	 logic select_turn;
	 logic en_turn_timer;
	 logic [83:0] new_game, Q_reg_game;
	 
	 
	 
	 assign debug_colum = Q_reg_Column;
		 
	 
	 clk_div CLK25(
		.clk(clk),
		.rst_active(rst),
		.clk25(clk25)
	 
	 );
	
	 
	 
	 
	 

	 
//===============logica turno================== 
	 
	 Mux #(.N(3)) Mux_Player(
		.A(player1),
		.B(player0),
		.S(select_turn),
		.C(play)
	 
	 );
	 
	 //contador de turno
	 
	 Counter #(.N(1)) Count_Turn(
	 .clk(clk25),
    .rst(rst),
    .en(en_turn),
    .mode(1'b1),                
    .Q(select_turn)

	 
	 );
	 
	
//===============logica columna / jugada================== 
	 
	 // Contador columna
	 Counter #(.N(3)) Count_Column(
	 .clk(clk25),
    .rst(rst | rst_column),
    .en(en_count_column),
    .mode(mode_count_column),                
    .Q(Q_reg_Column)

	 
	 );

	 
	 // Comparador Columna Derecha
	 Comparator #(.N(3)) Comp_Column_Right(
			.A(Q_reg_Column),
			.B(3'd6),
			.equ(comp_right)
	 );
	 
	 
	 // Comparador Columna Izquierda
	 Comparator #(.N(3)) Comp_Column_Left(
		.A(Q_reg_Column),
		.B(3'd0),
		.equ(comp_left)
	 );
	
//===============logica juego================== 
	
	// Registro de juego
	Register #(.N(84)) Reg_game_M(
		.clk(clk25),
		.rst(rst | rst_game),
		.D(new_game),
		.en(en_new_game),
		.Q(Q_reg_game)
	);
	
//===============logica timeout================== 

	// Contador tiempo
	Counter #(.N(28)) Count_turn_time(
		.clk(clk25),
		.rst(rst | rst_timer),
		.en(en_turn_timer),
		.mode(1'b1),                
		.Q(Q_reg_count_time)
	);
	
	// Comparador de contador tiempo
	 Comparator #(.N(28)) Comp_count_turn_time(
		.A(Q_reg_count_time),
		.B(28'd250_000_000),
		.equ(time_out)
	 );
	 
//===============logica random================== 
	 Counter #(.N(3)) Count_Random(
		.clk(clk25),
		.rst(rst | rst_random),
		.en(en_random_play),
		.mode(1'b1),                
		.Q(Q_reg_random)
		);
		
	
	Comparator #(.N(3)) Compa_Random(
		.A(Q_reg_random),
		.B(3'd7),
		.equ(comp_random)
	 );
	 
	 
//===============reg jugada================== 

		logic [3:0] Move;
		logic [3:0] Random_Move;
		assign Move = {select_turn, Q_reg_Column};
		assign Random_Move = {select_turn, Q_reg_random};
	
	 Register #(.N(4)) Reg_Play(
		.clk(clk25),
		.rst(rst),
		.D(Move),
		.en(1'b1),
		.Q(Q_reg_Play)
	 
	 );
	 
		 Register #(.N(1)) Reg_Select_Move(
		.clk(clk25),
		.rst(rst),
		.D(play_selection),
		.en(en_reg_selection),
		.Q(Q_Reg_Select_Move)
	 
	 );
	 
	 
	 Mux #(.N(4)) Mux_Play(
	 	.A(Q_reg_Play),
		.B(Random_Move),
		.S(Q_Reg_Select_Move),
		.C(c_Mux_Play)
	 
	 );
	 
	 
	 
	 Write_play WP_inst(
	 .game(Q_reg_game),
    .play(c_Mux_Play),
    .new_game(new_game),
    .s(valid_play)
	 
	 );
	 
	 
	 Check_win CW_Inst(
	 .reg_game_M(Q_reg_game), 
    .reg_jugada(c_Mux_Play), 
    .S(winning) 
	 );
	 
	 

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
        .display_select(display_select),
		  .en_turn_timer(en_turn_timer),
		  .state_debug(state_debug),
		  .rst_column(rst_column)
    );
	 
	 
		always_ff @(posedge clk25) begin
		 $display("Q_reg_Column: %0d", Q_reg_Column);
	end

	 
	 Game_Display GD (
		.game(84'h00),
		.column(Q_reg_Column),
		.Q_X(Q_X),
		.Q_Y(Q_Y),
		.R(R),
		.G(G), 
		.B(B)
		);
		

    // Instancia del controlador VGA
    Vga_Controller vga_inst (
        .clk(clk25),
        .rst(rst),
        .Hs(Hs),
        .Vs(Vs),
		  .VGA_Blank(VGA_Blank),
		  .VGA_Sync_N(VGA_Sync_N),
		  .Q_X(Q_X), 
		  .Q_Y(Q_Y)
    );

endmodule
