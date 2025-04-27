module Check_win(
    input logic [83:0] reg_game_M,  // 7 columnas x 6 filas x 2 bits = 84 bits
    output logic S                  // Señal de victoria
);

    // Parámetros para la matriz
    localparam WIDTH = 7;  // columnas
    localparam HEIGHT = 6; // filas
    localparam CONECTA = 4; // cantidad de piezas consecutivas para ganar

    // Verificación de victoria
    always_comb begin
        S = 0; // Inicialmente no hay victoria
        
        // Comprobación de victorias horizontales
        for (int y = 0; y < HEIGHT; y++) begin
            for (int x = 0; x <= WIDTH - CONECTA; x++) begin
                logic [1:0] player;
                player = reg_game_M[(y * WIDTH + x) * 2 +: 2];  // Obtener el valor de la celda
                if (player != 2'b00 && 
                    player == reg_game_M[((y * WIDTH + x + 1) * 2) +: 2] && 
                    player == reg_game_M[((y * WIDTH + x + 2) * 2) +: 2] && 
                    player == reg_game_M[((y * WIDTH + x + 3) * 2) +: 2]) begin
                    S = 1; // Victoria horizontal
                end
            end
        end
        
        // Comprobación de victorias verticales
        for (int x = 0; x < WIDTH; x++) begin
            for (int y = 0; y <= HEIGHT - CONECTA; y++) begin
                logic [1:0] player;
                player = reg_game_M[(y * WIDTH + x) * 2 +: 2];  // Obtener el valor de la celda
                if (player != 2'b00 && 
                    player == reg_game_M[((y + 1) * WIDTH + x) * 2 +: 2] && 
                    player == reg_game_M[((y + 2) * WIDTH + x) * 2 +: 2] && 
                    player == reg_game_M[((y + 3) * WIDTH + x) * 2 +: 2]) begin
                    S = 1; // Victoria vertical
                end
            end
        end
        
        // Comprobación de victorias diagonales (de izquierda a derecha)
        for (int x = 0; x <= WIDTH - CONECTA; x++) begin
            for (int y = 0; y <= HEIGHT - CONECTA; y++) begin
                logic [1:0] player;
                player = reg_game_M[(y * WIDTH + x) * 2 +: 2];  // Obtener el valor de la celda
                if (player != 2'b00 && 
                    player == reg_game_M[((y + 1) * WIDTH + x + 1) * 2 +: 2] && 
                    player == reg_game_M[((y + 2) * WIDTH + x + 2) * 2 +: 2] && 
                    player == reg_game_M[((y + 3) * WIDTH + x + 3) * 2 +: 2]) begin
                    S = 1; // Victoria diagonal izquierda a derecha
                end
            end
        end
        
        // Comprobación de victorias diagonales (de derecha a izquierda)
        for (int x = 3; x < WIDTH; x++) begin
            for (int y = 0; y <= HEIGHT - CONECTA; y++) begin
                logic [1:0] player;
                player = reg_game_M[(y * WIDTH + x) * 2 +: 2];  // Obtener el valor de la celda
                if (player != 2'b00 && 
                    player == reg_game_M[((y + 1) * WIDTH + x - 1) * 2 +: 2] && 
                    player == reg_game_M[((y + 2) * WIDTH + x - 2) * 2 +: 2] && 
                    player == reg_game_M[((y + 3) * WIDTH + x - 3) * 2 +: 2]) begin
                    S = 1; // Victoria diagonal derecha a izquierda
                end
            end
        end
    end

endmodule
