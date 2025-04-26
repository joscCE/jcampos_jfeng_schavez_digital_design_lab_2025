module Write_play(
    input  logic [83:0] game,
    input  logic [3:0]  play,
    output logic [83:0] new_game,
    output logic        s
);

    logic valid;
    logic [83:0] temp;
    logic [2:0] fila_cambiar;
    logic [5:0] filas;
    logic player;
    logic [2:0] col;

    assign player = play[3];
    assign col    = 6 - play[2:0];

    // Leer el estado de ocupación de cada fila en la columna seleccionada
    always_comb begin
        filas = 6'b0;
        for (int fila = 0; fila < 6; fila++) begin
             filas[fila] = game[col*2 + 14*fila];
        end
    end

    assign s = ~(&filas);
    assign valid = s;

    // Detectar la primera fila libre
    always_comb begin
        case(filas)
            6'b000000: fila_cambiar = 3'd0;
            6'b000001: fila_cambiar = 3'd1;
            6'b000011: fila_cambiar = 3'd2;
            6'b000111: fila_cambiar = 3'd3;
            6'b001111: fila_cambiar = 3'd4;
            6'b011111: fila_cambiar = 3'd5;
            default:   fila_cambiar = 3'd0;
        endcase
    end

    // Actualizar el juego
    always_comb begin
        temp = game;
        if (valid) begin
            temp[col*2 + 14*fila_cambiar] = 1'b1;       // Marcar celda como ocupada
            temp[col*2 + 14*fila_cambiar + 1] = player;  // Guardar quién la jugó
        end
    end

    assign new_game = temp;

endmodule
