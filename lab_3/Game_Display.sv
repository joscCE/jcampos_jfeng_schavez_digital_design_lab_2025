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
    localparam int BOARD_W = TILE_W * BOARD_COLS; // 490
    localparam int BOARD_H = TILE_H * BOARD_ROWS; // 420
    localparam int OFFSET_X = (640 - BOARD_W) / 2; // 75
    localparam int OFFSET_Y = (480 - BOARD_H) / 2; // 30

    // Variables internas
    logic [9:0] local_x, local_y;
    logic [6:0] rel_x, rel_y;
    logic [12:0] addr;
    logic [23:0] color;
    logic inside_board;

    // Determinar si estamos dentro del tablero
    assign inside_board = (Q_X >= OFFSET_X) && (Q_X < OFFSET_X + BOARD_W) &&
                          (Q_Y >= OFFSET_Y) && (Q_Y < OFFSET_Y + BOARD_H);

    // Calcular dirección de acceso a la ROM
    always_comb begin
        // Valores por defecto para evitar inferencia de latch
        local_x = 0;
        local_y = 0;
        rel_x   = 0;
        rel_y   = 0;
        addr    = 0;

        if (inside_board) begin
            local_x = Q_X - OFFSET_X;
            local_y = Q_Y - OFFSET_Y;
            rel_x   = local_x % TILE_W;
            rel_y   = local_y % TILE_H;
            addr    = rel_y * TILE_W + rel_x;
        end
    end

    // Instancia de la ROM de la ficha
    Piece_ROM rom (
        .addr(addr),
        .color(color)
    );

    // Selección de color final
    always_comb begin
        if (inside_board) begin
            R = color[23:16];
            G = color[15:8];
            B = color[7:0];
        end else begin
            R = 8'd255; // blanco fuera del tablero
            G = 8'd255;
            B = 8'd255;
        end
    end

endmodule
