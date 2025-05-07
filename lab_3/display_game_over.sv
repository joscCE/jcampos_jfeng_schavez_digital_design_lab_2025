module display_game_over(
    input  logic [83:0] game,
    input  logic [2:0]  column,
    input  logic [10:0] Win_play,
    input  logic        S,
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

    // Extraer información del movimiento ganador
    logic [6:0] play_made;
    logic win_horiz, win_vert, win_diag1, win_diag2;
    assign play_made = Win_play[10:4];
    assign win_horiz = Win_play[3];
    assign win_vert  = Win_play[2];
    assign win_diag1 = Win_play[1];
    assign win_diag2 = Win_play[0];

    logic [2:0] win_col, win_row;
    assign win_col = play_made[5:3];
    assign win_row = play_made[2:0];

    // Variables internas
    logic [9:0] local_x, local_y;
    logic [6:0] rel_x, rel_y;
    logic [12:0] addr;
    logic [23:0] color;
    logic inside_board;
    logic inside_indicator;
    logic [2:0] safe_column;
    logic       valid_column;

    logic [2:0] col_idx, row_idx;
    logic [2:0] logical_col_idx, logical_row_idx;
    logic [6:0] tile_index;
    logic owner_bit, occupied_bit;

    assign safe_column = (column < 7) ? column : 3'd6;
    assign valid_column = (column < 7);

    assign column_x_start = OFFSET_X + (safe_column * TILE_W);
    assign column_x_end   = column_x_start + TILE_W;

    assign inside_board = (Q_X >= OFFSET_X) && (Q_X < OFFSET_X + BOARD_W) &&
                          (Q_Y >= OFFSET_Y) && (Q_Y < OFFSET_Y + BOARD_H);

    assign inside_indicator = valid_column &&
                              (Q_Y >= OFFSET_Y - 20) && (Q_Y < OFFSET_Y) &&
                              (Q_X >= column_x_start) && (Q_X < column_x_end);

    logic is_winning_cell;

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
        logical_col_idx = 0;
        logical_row_idx = 0;

        if (inside_board) begin
            local_x = Q_X - OFFSET_X;
            local_y = Q_Y - OFFSET_Y;

            rel_x = local_x % TILE_W;
            rel_y = local_y % TILE_H;
            addr  = rel_y * TILE_W + rel_x;

            col_idx = local_x / TILE_W;
            row_idx = local_y / TILE_H;

            logical_col_idx = BOARD_COLS - 1 - col_idx;
            logical_row_idx = BOARD_ROWS - 1 - row_idx;

            tile_index = logical_row_idx * BOARD_COLS + logical_col_idx;

            occupied_bit = game[tile_index * 2];
            owner_bit    = game[tile_index * 2 + 1];
        end
    end

    always_comb begin
        is_winning_cell = 1'b0;

        if (inside_board && occupied_bit) begin
            case (1'b1)
                win_horiz: is_winning_cell = (logical_row_idx == win_row);
                win_vert:  is_winning_cell = (logical_col_idx == win_col);
                win_diag1: is_winning_cell = ((logical_col_idx - win_col) == (logical_row_idx - win_row));
                win_diag2: is_winning_cell = ((logical_col_idx - win_col) == -(logical_row_idx - win_row));
                default:   is_winning_cell = 1'b0;
            endcase
        end
    end

    Piece_ROM rom (
        .addr(addr),
        .color(color)
    );

    always_comb begin
        if (inside_indicator) begin
            R = 8'd255; G = 8'd255; B = 8'd0; // Indicador amarillo
        end else if (inside_board) begin
            if (occupied_bit) begin
                if (is_winning_cell) begin
                    R = 8'd255; G = color[15:8]; B = 8'd0; // Jugador 0 - verde
                end else if (owner_bit == 1'b0) begin
                    R = 8'd0; G = color[15:8]; B = 8'd0; // Jugador 0 - verde
                end else begin
                    R = color[7:0]; G = 8'd0; B = 8'd0; // Jugador 1 - rojo
                end
            end else begin
                R = color[23:16]; G = color[15:8]; B = color[7:0]; // Casilla vacía
            end
        end else begin
            R = 8'd255; G = 8'd255; B = 8'd255; // Fondo
        end
    end

endmodule
