module Game_Display(
    input  logic [83:0] game,
    input  logic [2:0]  column,
    input  logic [9:0]  Q_X, Q_Y,
    output logic [7:0]  R, G, B
);

    // Constantes del tablero
    localparam int TILE_W = 70;
    localparam int TILE_H = 70;
    localparam int BOARD_COLS = 7;
    localparam int BOARD_ROWS = 6;
    localparam int BOARD_W = TILE_W * BOARD_COLS;
    localparam int BOARD_H = TILE_H * BOARD_ROWS;
    localparam int OFFSET_X = (640 - BOARD_W) / 2;
    localparam int OFFSET_Y = (480 - BOARD_H) / 2;

    // Variables internas
    logic [9:0] local_x, local_y;
    logic [6:0] rel_x, rel_y;
    logic [12:0] addr;
    logic [23:0] color;
    logic inside_board;
    logic inside_indicator;
    logic [2:0] safe_column;
    logic       valid_column;

    // Posiciones de celda
    logic [2:0] col_idx;
    logic [2:0] row_idx;
    logic [6:0] tile_index;
    logic owner_bit, occupied_bit;

    // Protección por si column > 6
    assign safe_column = (column < 7) ? column : 3'd6;
    assign valid_column = (column < 7);

    // Cálculo del área horizontal de la columna seleccionada
    logic [9:0] column_x_start, column_x_end;
    assign column_x_start = OFFSET_X + (safe_column * TILE_W);
    assign column_x_end   = column_x_start + TILE_W;

    // Detectar si estamos dentro del tablero
    assign inside_board = (Q_X >= OFFSET_X) && (Q_X < OFFSET_X + BOARD_W) &&
                          (Q_Y >= OFFSET_Y) && (Q_Y < OFFSET_Y + BOARD_H);

    // Detectar si estamos en la zona del indicador
    assign inside_indicator = valid_column &&
                              (Q_Y >= OFFSET_Y - 20) && (Q_Y < OFFSET_Y) &&
                              (Q_X >= column_x_start) && (Q_X < column_x_end);

    // Calcular dirección de acceso y estado de casilla
    always_comb begin
        local_x = 0;
        local_y = 0;
        rel_x   = 0;
        rel_y   = 0;
        addr    = 0;
        col_idx = 0;
        row_idx = 0;
        tile_index = 0;
        occupied_bit = 0;
        owner_bit = 0;

        if (inside_board) begin
            local_x = Q_X - OFFSET_X;
            local_y = Q_Y - OFFSET_Y;

            rel_x = local_x % TILE_W;
            rel_y = local_y % TILE_H;
            addr = rel_y * TILE_W + rel_x;

            col_idx = local_x / TILE_W;
            row_idx = local_y / TILE_H;

            tile_index = row_idx * BOARD_COLS + (BOARD_COLS - 1 - col_idx); // INVERSIÓN

            occupied_bit = game[tile_index * 2];
            owner_bit    = game[tile_index * 2 + 1];
        end
    end

    // Instancia de la ROM de la ficha
    Piece_ROM rom (
        .addr(addr),
        .color(color)
    );

    // Color final
    always_comb begin
        if (inside_indicator) begin
            R = 8'd255;
            G = 8'd255;
            B = 8'd0;
        end else if (inside_board) begin
            if (occupied_bit) begin
                if (owner_bit == 1'b0) begin
                   B = 8'd0; G = color[15:8]; R = 8'd0; // Jugador 0 - verde
                end else begin
                    B = 8'd0; G = 8'd0; R = color[7:0];   // Jugador 1 - azul
                end
            end else begin
                R = color[23:16]; G = color[15:8]; B = color[7:0]; // Vacía
            end
        end else begin
            R = 8'd255; G = 8'd255; B = 8'd255; // Fondo
        end
    end

endmodule
