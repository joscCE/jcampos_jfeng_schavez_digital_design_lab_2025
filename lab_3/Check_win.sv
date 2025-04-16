module Check_win(
    input  logic [83:0] reg_game_M, // Tablero codificado (7x6 con 2 bits por celda)
    input  logic [5:0]  reg_jugada, // Jugada reciente: [5:3] = fila, [2:0] = columna
    output logic        S           // Señal de victoria (1 si alguien ganó)
);

    // Separar fila y columna de la jugada
    logic [2:0] fila, columna;
    logic [1:0] jugador;

    assign fila = reg_jugada[5:3];
    assign columna = reg_jugada[2:0];

    // Función que cuenta fichas en una dirección
    function automatic int contar(
        input int row, col,
        input int dx, dy,
        input logic [1:0] jugador,
        input logic [83:0] board
    );
        int count = 0;
        int r, c, idx;
        for (int i = 1; i < 4; i++) begin
            r = row + dy * i;
            c = col + dx * i;
            if (r < 0 || r >= 6 || c < 0 || c >= 7)
                break;
            idx = (r * 7 + c) * 2;
            if (board[idx +: 2] == jugador)
                count++;
            else
                break;
        end
        return count;
    endfunction

    // Lógica combinacional principal
    always_comb begin
        jugador = reg_game_M[(fila * 7 + columna) * 2 +: 2];
        S = 0;

        if (jugador != 2'b00) begin
            // Horizontal
            if (contar(fila, columna, 1, 0, jugador, reg_game_M) +
                contar(fila, columna, -1, 0, jugador, reg_game_M) >= 3)
                S = 1;
            // Vertical
            else if (contar(fila, columna, 0, 1, jugador, reg_game_M) +
                     contar(fila, columna, 0, -1, jugador, reg_game_M) >= 3)
                S = 1;
            // Diagonal /
            else if (contar(fila, columna, 1, -1, jugador, reg_game_M) +
                     contar(fila, columna, -1, 1, jugador, reg_game_M) >= 3)
                S = 1;
            // Diagonal \
            else if (contar(fila, columna, 1, 1, jugador, reg_game_M) +
                     contar(fila, columna, -1, -1, jugador, reg_game_M) >= 3)
                S = 1;
        end
    end

endmodule
