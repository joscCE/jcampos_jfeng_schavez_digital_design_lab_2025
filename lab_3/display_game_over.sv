module display_game_over(
	input logic clk, 
    input  logic [83:0] game,
    input  logic [2:0]  column,
	 input logic turn,
    input  logic        S,
	 
	 input logic [1:0] win_type,       // 00=horizontal, 01=vertical, 10=diagonal \, 11=diagonal /
    input logic [2:0] win_base_col,   // Columna base de la secuencia ganadora
    input logic [2:0] win_base_row,   // Fila base de la secuencia ganadora
	 
	 
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
	 
	 
	 localparam int IMG_W = 200;
		localparam int IMG_H = 200;
		localparam int IMG_X = (640 - IMG_W) / 2;
		localparam int IMG_Y = (480 - IMG_H) / 2;

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
	 
	 logic [13:0] win_addr;
	logic [23:0] win_color_p1, win_color_p2;
	logic inside_win_image;

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
										
			logic [2:0] logic_col, logic_row;						
										
										
		 function logic is_winning_token(input [2:0] current_col, input [2:0] current_row);
		 if (!S) return 0; // Si no hay victoria, no hay fichas ganadoras
		 
		 case (win_type)
			  2'b00: // Horizontal
					return (current_row >= (win_base_row));

			  2'b01: // Vertical
					return (current_col == win_base_col) && 
							 (current_row >= win_base_row) && 
							 (current_row < win_base_row + 4);
			  2'b10: // Diagonal \
					return (current_col - win_base_col == current_row - win_base_row) &&
							 (current_col - win_base_col >= 0) &&
							 (current_col - win_base_col < 4);
			  2'b11: // Diagonal /
					return (win_base_col - current_col == current_row - win_base_row) &&
							 (win_base_col - current_col >= 0) &&
							 (win_base_col - current_col < 4);
			  default: return 0;
		 endcase
	endfunction

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
    logic_col = 0;
    logic_row = 0;
	 
	 
	 
		 if (S) begin
		 inside_win_image = (Q_X >= IMG_X) && (Q_X < IMG_X + IMG_W) &&
								  (Q_Y >= IMG_Y) && (Q_Y < IMG_Y + IMG_H);
		 win_addr = (Q_Y - IMG_Y) * IMG_W + (Q_X - IMG_X);
	end else begin
		 inside_win_image = 0;
		 win_addr = 0;
	end
	 

    if (inside_board) begin
        local_x = Q_X - OFFSET_X;
        local_y = Q_Y - OFFSET_Y;

        rel_x = local_x % TILE_W;
        rel_y = local_y % TILE_H;
        addr = rel_y * TILE_W + rel_x;

        col_idx = local_x / TILE_W;
        row_idx = local_y / TILE_H;

        tile_index = (BOARD_ROWS - 1 - row_idx) * BOARD_COLS + (BOARD_COLS - 1 - col_idx);

        occupied_bit = game[tile_index * 2];
        owner_bit    = game[tile_index * 2 + 1];

        // 💥 Asignar coordenadas lógicas aquí, cuando col_idx y row_idx ya están actualizados
        logic_col = BOARD_COLS - 1 - col_idx;
        logic_row = BOARD_ROWS  - row_idx;
    end
end

    // Instancia de la ROM de la ficha
    Piece_ROM rom (
        .addr(addr),
        .color(color)
    );
	 
	 
		 
		 // ROMs para las imágenes de victoria
	Win_p1_ROM rom_p1 (
		 .addr(win_addr),
		 .color(win_color_p1)
	);

	Win_p2_ROM rom_p2 (
		 .addr(win_addr),
		 .color(win_color_p2)
	);

    // Color final
always_comb begin
    if (S && inside_win_image) begin
        // Mostrar imagen de victoria centrada según el turno
        if (turn == 1'b0) begin
            R = win_color_p1[23:16];
            G = win_color_p1[15:8];
            B = win_color_p1[7:0];
        end else begin
            R = win_color_p2[23:16];
            G = win_color_p2[15:8];
            B = win_color_p2[7:0];
        end

    end else if (inside_indicator) begin
        R = 8'd255;
        G = 8'd255;
        B = 8'd0;

    end else if (inside_board) begin
        if (occupied_bit) begin
            if (S && is_winning_token(logic_col, logic_row)) begin
                // Resaltar fichas ganadoras en amarillo
                R = 8'd255;
                G = 8'd255;
                B = color[7:0];
            end else if (owner_bit == 1'b0) begin
                // Jugador 0 - verde
                B = 8'd0; 
                G = color[15:8]; 
                R = 8'd0;
            end else begin
                // Jugador 1 - rojo
                B = 8'd0; 
                G = 8'd0; 
                R = color[7:0];
            end
        end else begin
            // Casilla vacía
            R = color[23:16]; 
            G = color[15:8]; 
            B = color[7:0];
        end

    end else begin
        // Fondo blanco
        R = 8'd255; 
        G = 8'd255; 
        B = 8'd255;
    end
end

endmodule


