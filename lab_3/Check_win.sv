module Check_win(
    input  logic [83:0] reg_game_M,   // La matriz de juego
    input  logic [6:0]  play_made,     // Movimiento realizado
    output logic        S,            // Señal de victoria
	 output logic [10:0] Win_play
);

    logic [2:0] col;                   // Columna del movimiento
    logic [2:0] fila;                  // Fila del movimiento
    logic player;                      // Jugador que hizo el movimiento

    // Cuentan las piezas en cada dirección
    logic [3:0] count_horiz, count_vert, count_diag1, count_diag2;

    // Señales de victoria por dirección
    logic win_horiz, win_vert, win_diag1, win_diag2;

    assign player = play_made[6];       // Jugador que hace el movimiento (0 o 1)
    assign col = play_made[5:3];       // Columna del movimiento
    assign fila = play_made[2:0];      // Fila del movimiento

    // Función para verificar si una celda coincide con el jugador
    function logic cell_matches(input logic [2:0] c, input logic [2:0] f);
    if (c > 6 || f > 5) return 0; // Fuera de límites
    // Celda debe estar ocupada Y ser del jugador actual
		return (reg_game_M[c*2 + f*14] && (reg_game_M[c*2 + f*14 + 1] == player));
	endfunction

    always_comb begin
        // Contador
        count_horiz = 1;
        count_vert = 1;
        count_diag1 = 1;
        count_diag2 = 1;

        // Verificación en dirección horizontal
        // derecha
        for (int i = 1; i < 4; i++) begin
            if (col+i <= 6 && count_horiz < 4 && cell_matches(col+i, fila)) 
                count_horiz++;
        end
        // izquierda
        for (int i = 1; i < 4; i++) begin
            if (col-i >= 0 && count_horiz < 4 && cell_matches(col-i, fila)) 
                count_horiz++;
        end

        // Verificación en dirección vertical 
        for (int i = 1; i < 4; i++) begin
            if (fila-i >= 0 && count_vert < 4 && cell_matches(col, fila-i)) 
                count_vert++;
        end

        // Verificación en diagonal
        // diagonal abajo-derecha
        for (int i = 1; i < 4; i++) begin
            if (col+i <= 6 && fila-i >= 0 && count_diag1 < 4 && cell_matches(col+i, fila-i)) 
                count_diag1++;
        end
        // diagonal arriba-izquierda
        for (int i = 1; i < 4; i++) begin
            if (col-i >= 0 && fila+i <= 5 && count_diag1 < 4 && cell_matches(col-i, fila+i)) 
                count_diag1++;
        end

        // Verificación en diagonal
        // ↙ diagonal abajo-izquierda
        for (int i = 1; i < 4; i++) begin
            if (col-i >= 0 && fila-i >= 0 && count_diag2 < 4 && cell_matches(col-i, fila-i)) 
                count_diag2++;
        end
        // ↗ diagonal arriba-derecha
        for (int i = 1; i < 4; i++) begin
            if (col+i <= 6 && fila+i <= 5 && count_diag2 < 4 && cell_matches(col+i, fila+i)) 
                count_diag2++;
        end

        // Comprobamos si alguna dirección alcanzó 4 piezas consecutivas
        win_horiz = (count_horiz >= 4);
        win_vert  = (count_vert  >= 4);
        win_diag1 = (count_diag1 >= 4);
        win_diag2 = (count_diag2 >= 4);

        // Si alguna dirección tiene 4 piezas consecutivas, es un ganador
        S = win_horiz | win_vert | win_diag1 | win_diag2;
    end
	 
	 assign Win_play = {play_made,win_horiz,win_vert,win_diag1,win_diag2};
	 
	 
	 
	 

endmodule


