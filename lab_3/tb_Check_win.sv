module tb_Check_win();

    logic [83:0] game;
    logic [5:0]  jugada;
    logic        win;

    // Instancia del módulo a probar
    Check_win uut (
        .reg_game_M(game),
        .reg_jugada(jugada),
        .S(win)
    );

    // Helper: establece el valor de una celda
    function automatic void set_cell(
        inout logic [83:0] board,
        input int row, col,
        input logic [1:0] player
    );
        int idx = (row * 7 + col) * 2;
        board[idx +: 2] = player;
    endfunction

    task automatic reset_game();
        game = '0;
        win  = 0;
    endtask

initial begin
    $display("---- INICIANDO TESTS DE VICTORIA ----");

    // -------------------------------
    // 1. Victoria Horizontal
    reset_game();
    set_cell(game, 2, 2, 2'b01);
    set_cell(game, 2, 3, 2'b01);
    set_cell(game, 2, 4, 2'b01);
    set_cell(game, 2, 5, 2'b01);
    jugada = {3'd2, 3'd5}; // fila 2, columna 5
    #1;
    $display("HORIZONTAL: %s", win ? "PASO" : "FALLO");

    // -------------------------------
    // 2. Victoria Vertical
    reset_game();
    set_cell(game, 1, 4, 2'b01);
    set_cell(game, 2, 4, 2'b01);
    set_cell(game, 3, 4, 2'b01);
    set_cell(game, 4, 4, 2'b01);
    jugada = {3'd4, 3'd4};
    #1;
    $display("VERTICAL: %s", win ? "PASO" : "FALLO");

    // -------------------------------
    // 3. Diagonal ↘ (descendente)
    reset_game();
    set_cell(game, 0, 0, 2'b01);
    set_cell(game, 1, 1, 2'b01);
    set_cell(game, 2, 2, 2'b01);
    set_cell(game, 3, 3, 2'b01);
    jugada = {3'd3, 3'd3};
    #1;
    $display("DIAGONAL Abajo: %s", win ? "PASO" : "FALLO");

    // -------------------------------
    // 4. Diagonal ↗ (ascendente)
    reset_game();
    set_cell(game, 3, 0, 2'b01);
    set_cell(game, 2, 1, 2'b01);
    set_cell(game, 1, 2, 2'b01);
    set_cell(game, 0, 3, 2'b01);
    jugada = {3'd0, 3'd3};
    #1;
    $display("DIAGONAL Arriba: %s", win ? "PASO" : "FALLO");

    // -------------------------------
    // 5. Sin victoria
    reset_game();
    set_cell(game, 5, 0, 2'b10);
    set_cell(game, 5, 1, 2'b01);
    set_cell(game, 5, 2, 2'b10);
    set_cell(game, 5, 3, 2'b01);
    jugada = {3'd5, 3'd3};
    #1;
    $display("SIN VICTORIA: %s", (win == 0) ? "PASO" : "FALLO");

    $display("---- FIN DE PRUEBAS ----");
    $finish;
end


endmodule
