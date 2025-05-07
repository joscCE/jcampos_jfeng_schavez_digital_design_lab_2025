module display_game_over(
    input  logic [83:0] game,
    input  logic [2:0]  column,
    input  logic [2:0]  start_row, start_col,
    input  logic [2:0]  end_row,   end_col,
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
    logic [9:0] column_x_start, column_x_end;
    logic is_winning_cell;

    logic signed [2:0] win_dir_row, win_dir_col;

    assign safe_column = (column < 7) ? column : 3'd6;
    assign valid_column = (column < 7);

    assign column_x_start = OFFSET_X + (safe_column * TILE_W);
    assign column_x_end   = column_x_start + TILE_W;

    assign inside_board = (Q_X >= OFFSET_X) && (Q_X < OFFSET_X + BOARD_W) &&
                          (Q_Y >= OFFSET_Y) && (Q_Y < OFFSET_Y + BOARD_H);

    assign inside_indicator = valid_column &&
                              (Q_Y >= OFFSET_Y - 20) && (Q_Y < OFFSET_Y) &&
                              (Q_X >= column_x_start) && (Q_X < column_x_end);

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

    // Dirección de victoria
    always_comb begin
        win_dir_row = 0;
        win_dir_col = 0;

        if (S) begin
            if (start_row < end_row) win_dir_row = 1;
            else if (start_row > end_row) win_dir_row = -1;

            if (start_col < end_col) win_dir_col = 1;
            else if (start_col > end_col) win_dir_col = -1;
        end
    end

    // Verificar si la celda actual es una de las ganadoras
always_comb begin
    is_winning_cell = 1'b0;

    if (S && inside_board && occupied_bit) begin
				  logic [2:0] check_row, check_col;
		logic [2:0] logical_check_row, logical_check_col;

		for (int i = 0; i < 4; i++) begin
			 check_row = start_row + i * win_dir_row;
			 check_col = start_col + i * win_dir_col;

			 // Convertimos para comparar con logical_row_idx
			 logical_check_row = BOARD_ROWS - 1 - check_row;
			 logical_check_col = BOARD_COLS - 1 - check_col;

			 if (logical_row_idx == logical_check_row && logical_col_idx == logical_check_col) begin
				  is_winning_cell = 1'b1;
			 end
		end
    end
end

    Piece_ROM rom (
        .addr(addr),
        .color(color)
    );

    // Salida de color
    always_comb begin
        if (inside_indicator) begin
            R = 8'd255; G = 8'd255; B = 8'd0;
        end else if (inside_board) begin
            if (occupied_bit) begin
                if (is_winning_cell) begin
                    R = 8'd255; G = 8'd255; B = 8'd0; // Amarillo para celda ganadora
                end else if (owner_bit == 1'b0) begin
                    R = 8'd255; G = color[15:8]; B = 8'd0;
                end else begin
                    R = color[7:0]; G = 8'd0; B = 8'd0;
                end
            end else begin
                R = color[23:16]; G = color[15:8]; B = color[7:0];
            end
        end else begin
            R = 8'd255; G = 8'd255; B = 8'd255;
        end
    end

endmodule
