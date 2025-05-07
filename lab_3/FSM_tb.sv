module FSM_tb;

  // Entradas
  logic clk, rst, L, R, time_out, winning, valid_play, play, start;
  logic comp_right, comp_left, comp_random;
  logic p1, p0;

  // Salidas
  logic rst_timer, rst_turn, rst_game, rst_random;
  logic en_turn, en_count_column, en_random_play, en_new_game, en_reg_selection;
  logic mode_count_column, play_selection, en_turn_timer;
  logic [1:0] display_select;
  logic [3:0] state_debug;

  // Instancia del módulo FSM
  FSM dut (
    .clk(clk), .rst(rst), .L(L), .R(R), .time_out(time_out), .winning(winning),
    .valid_play(valid_play), .play(play), .start(start),
    .comp_right(comp_right), .comp_left(comp_left), .comp_random(comp_random),
    .p1(p1), .p0(p0),
    .rst_timer(rst_timer), .rst_turn(rst_turn), .rst_game(rst_game), .rst_random(rst_random),
    .en_turn(en_turn), .en_count_column(en_count_column), .en_random_play(en_random_play),
    .en_new_game(en_new_game), .en_reg_selection(en_reg_selection),
    .mode_count_column(mode_count_column), .play_selection(play_selection),
    .en_turn_timer(en_turn_timer), .display_select(display_select), .state_debug(state_debug)
  );

  // Reloj
  always #5 clk = ~clk;
  
	task check_state(logic [3:0] esperado);
	  if (state_debug !== esperado)
		 $display("Estado actual: %04b | Esperado: %04b", state_debug, esperado);
	  else
		 $display("Estado actual: %04b", state_debug);
	endtask


  initial begin
    clk = 0;
    rst = 1; L = 0; R = 0; time_out = 0; winning = 0; valid_play = 1; play = 0; start = 0;
    comp_right = 0; comp_left = 0; comp_random = 0;
    p0 = 0; p1 = 0;

    $display("# Iniciando testbench...");
    // Reset
    rst = 1; #10;
    rst = 0; #10;
    check_state(4'b0000);

    // Caso 1: Inicia con p0
	 $display("Caso 1: Inicia con p0");
    p0 = 1; #10;
    check_state(4'b0001); // p0 activado → estado 0001
	 p0 = 0; #10;
    #10; check_state(4'b0000); // vuelve a 0000

    // Caso 2: Inicia con p1
	 $display("Caso 2: Inicia con p1");
    p1 = 1; #10;
	 check_state(4'b0010);
    p1 = 0; #10;
    #10; check_state(4'b0000);

    // Caso 3: start → R apretado → comp_right = 1
	 $display("Caso 3: start a R apretado a comp_right = 1");
    start = 1; #10;
    start = 0; #10;
    check_state(4'b0011);

    R = 1; #10;
    R = 0;
    comp_right = 1; #10;
    comp_right = 0;
    check_state(4'b0011); // Regresa a estado 0011

    // Caso 4: start → play → valid_play = 1 → winning = 1 → rst
	 $display("Caso 4: start a play a valid_play = 1 a winning = 1 a rst");
    rst = 1; #10; rst = 0; #10; // resetear FSM
    start = 1; #10; start = 0; #10;
    check_state(4'b0011);

    play = 1; #10;
    play = 0;
    valid_play = 1; #10;
    valid_play = 0;
    winning = 1; #10;
    check_state(4'b0111); // Debe estar en estado ganador

    rst = 1; #10;
    check_state(4'b0000);
	 
	 // Caso 5: start → play → valid_play = 1 → winning = 0 → debe ir a 1000 (no gana)
    $display("Caso 5: start a play a valid_play = 1 a winning = 0 a debe ir a 1000 (no gana)");
	 rst = 1; #10; rst = 0; #10;
    start = 1; #10; start = 0; #10;
    play = 1; #10; play = 0;
    valid_play = 1; #10; valid_play = 0;
    winning = 0; #10;
    check_state(4'b1000); // Estado para preparar siguiente turno
    #10;
    check_state(4'b0011); // Retorna a selección (estado 0011)

	 // Caso 6: start → time_out
	 $display("Caso 6: start a time_out");
    rst = 1; #10; rst = 0; #10;
    start = 1; #10; start = 0; #10;
    time_out = 1; #10; time_out = 0;
    check_state(4'b0100); // Estado por time_out
    #10;
    check_state(4'b0101); // Luego va a play automático
	 
	 // Caso 7: R apretado pero comp_right = 0 → va a 1010 y luego regresa
    $display("Caso 7: R apretado pero comp_right = 0 a va a 1010 y luego regresa");
	 rst = 1; #10; rst = 0; #10;
    start = 1; #10; start = 0; #10;
    R = 1; #10; R = 0;
    comp_right = 0; #10;
    check_state(4'b1010);
    #10;
    check_state(4'b0011); // Vuelve al estado de selección
	 
    // Caso 8: Verificación de señales de salida en estado 0111 (ganador)
    $display("Caso 8: Verificacion de senales de salida en estado 0111 (ganador)");
	 rst = 1; #10; rst = 0; #10;
    start = 1; #10; start = 0; #10;
    play = 1; #10; play = 0;
    valid_play = 1; #10;
    winning = 1; #10;
    #10;
    $display("rst_game (debe estar activo): %b", rst_game);
    $display("display_select (debe ser 01): %b", display_select);
    check_state(4'b0111);

    rst = 1; #10;
    check_state(4'b0000);

    // Fin
    $display("\n✅ Test finalizado con exito.");
    $finish;
  end


endmodule