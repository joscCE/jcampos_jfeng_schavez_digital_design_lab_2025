module Check_win(
    input  logic [83:0] reg_game_M,  // 7 columnas x 6 filas x 2 bits = 84 bits
    input  logic [4:0]  reg_jugada,  // [4] = jugador, [2:0] = columna (0-6)
    output logic        S            // Señal de victoria
);

    logic [2:0] fila;
    logic [2:0] columna;
    logic       jugador;
    logic [1:0] celda_tmp;  // <== MOVIDO AQUÍ

    assign jugador = reg_jugada[4];
    assign columna = reg_jugada[2:0];

    // Función para obtener una celda
    function automatic void get_celda(
        input int f, input int c,
        input logic [83:0] board,
        output logic [1:0] value
    );
        int idx;
        begin
            idx = (f * 7 + c) * 2;
            value[1] = board[idx + 1];
            value[0] = board[idx];
        end
    endfunction

    // Función para contar en una dirección
    function automatic int contar(
        input int row, col,
        input int dx, dy,
        input logic jugador_buscado,
        input logic [83:0] board
    );
        int count;
        int r, c;
        logic [1:0] celda;
        begin
            count = 0;
            for (int i = 1; i < 4; i = i + 1) begin
                r = row + dy * i;
                c = col + dx * i;
                if (r < 0 || r >= 6 || c < 0 || c >= 7)
                    break;
                get_celda(r, c, board, celda);
                if (celda[1] && celda[0] == jugador_buscado)
                    count = count + 1;
                else
                    break;
            end
            return count;
        end
    endfunction

    always_comb begin
        S = 0;
        fila = 0;

        // Buscar la fila más baja ocupada en esa columna
        for (int f = 0; f < 6; f = f + 1) begin
            get_celda(f, columna, reg_game_M, celda_tmp);
            if (celda_tmp[1])
                fila = f;
            else
                break;
        end

        get_celda(fila, columna, reg_game_M, celda_tmp);
        if (celda_tmp[1] && celda_tmp[0] == jugador) begin
            if ((contar(fila, columna, 1, 0, jugador, reg_game_M) +
                 contar(fila, columna, -1, 0, jugador, reg_game_M)) >= 3)
                S = 1;
            else if ((contar(fila, columna, 0, 1, jugador, reg_game_M) +
                      contar(fila, columna, 0, -1, jugador, reg_game_M)) >= 3)
                S = 1;
            else if ((contar(fila, columna, 1, -1, jugador, reg_game_M) +
                      contar(fila, columna, -1, 1, jugador, reg_game_M)) >= 3)
                S = 1;
            else if ((contar(fila, columna, 1, 1, jugador, reg_game_M) +
                      contar(fila, columna, -1, -1, jugador, reg_game_M)) >= 3)
                S = 1;
        end
    end

endmodule
