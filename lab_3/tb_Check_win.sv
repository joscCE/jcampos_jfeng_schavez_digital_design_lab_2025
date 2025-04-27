module tb_Check_win();

    logic [83:0] game;
    logic        win;

    // Instancia del módulo a probar
    Check_win uut (
        .reg_game_M(game),
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
    // 1. Victoria Horizontal para Jugador 1
    reset_game();
    set_cell(game, 2, 2, 2'b01);
    set_cell(game, 2, 3, 2'b01);
    set_cell(game, 2, 4, 2'b01);
    set_cell(game, 2, 5, 2'b01);
    #1;
    $display("HORIZONTAL Jugador 1: %s", win ? "PASO" : "FALLO");

    // -------------------------------
    // 2. Victoria Vertical para Jugador 1
    reset_game();
    set_cell(game, 1, 4, 2'b01);
    set_cell(game, 2, 4, 2'b01);
    set_cell(game, 3, 4, 2'b01);
    set_cell(game, 4, 4, 2'b01);
    #1;
    $display("VERTICAL Jugador 1: %s", win ? "PASO" : "FALLO");

    // -------------------------------
    // 3. Diagonal ↘ (descendente) para Jugador 1
    reset_game();
    set_cell(game, 0, 0, 2'b01);
    set_cell(game, 1, 1, 2'b01);
    set_cell(game, 2, 2, 2'b01);
    set_cell(game, 3, 3, 2'b01);
    #1;
    $display("DIAGONAL Abajo Jugador 1: %s", win ? "PASO" : "FALLO");

    // -------------------------------
    // 4. Diagonal ↗ (ascendente) para Jugador 1
    reset_game();
    set_cell(game, 3, 0, 2'b01);
    set_cell(game, 2, 1, 2'b01);
    set_cell(game, 1, 2, 2'b01);
    set_cell(game, 0, 3, 2'b01);
    #1;
    $display("DIAGONAL Arriba Jugador 1: %s", win ? "PASO" : "FALLO");

    // -------------------------------
    // 5. Sin victoria para Jugador 1
    reset_game();
    set_cell(game, 5, 0, 2'b10);
    set_cell(game, 5, 1, 2'b01);
    set_cell(game, 5, 2, 2'b10);
    set_cell(game, 5, 3, 2'b01);
    #1;
    $display("SIN VICTORIA Jugador 1: %s", (win == 0) ? "PASO" : "FALLO");

    // -------------------------------
    // 6. Victoria Horizontal para Jugador 2
    reset_game();
    set_cell(game, 2, 2, 2'b10);
    set_cell(game, 2, 3, 2'b10);
    set_cell(game, 2, 4, 2'b10);
    set_cell(game, 2, 5, 2'b10);
    #1;
    $display("HORIZONTAL Jugador 2: %s", win ? "PASO" : "FALLO");

    // -------------------------------
    // 7. Victoria Vertical para Jugador 2
    reset_game();
    set_cell(game, 1, 4, 2'b10);
    set_cell(game, 2, 4, 2'b10);
    set_cell(game, 3, 4, 2'b10);
    set_cell(game, 4, 4, 2'b10);
    #1;
    $display("VERTICAL Jugador 2: %s", win ? "PASO" : "FALLO");

    // -------------------------------
    // 8. Diagonal ↘ (descendente) para Jugador 2
    reset_game();
    set_cell(game, 0, 0, 2'b10);
    set_cell(game, 1, 1, 2'b10);
    set_cell(game, 2, 2, 2'b10);
    set_cell(game, 3, 3, 2'b10);
    #1;
    $display("DIAGONAL Abajo Jugador 2: %s", win ? "PASO" : "FALLO");

    // -------------------------------
    // 9. Diagonal ↗ (ascendente) para Jugador 2
    reset_game();
    set_cell(game, 3, 0, 2'b10);
    set_cell(game, 2, 1, 2'b10);
    set_cell(game, 1, 2, 2'b10);
    set_cell(game, 0, 3, 2'b10);
    #1;
    $display("DIAGONAL Arriba Jugador 2: %s", win ? "PASO" : "FALLO");

    // -------------------------------
    // 10. Sin victoria para Jugador 2
    reset_game();
    set_cell(game, 5, 0, 2'b01);
    set_cell(game, 5, 1, 2'b10);
    set_cell(game, 5, 2, 2'b01);
    set_cell(game, 5, 3, 2'b10);
    #1;
    $display("SIN VICTORIA Jugador 2: %s", (win == 0) ? "PASO" : "FALLO");

    $display("---- FIN DE PRUEBAS ----");
    $finish;
end

endmodule
