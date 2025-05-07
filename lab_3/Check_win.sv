module Check_win(
    input  logic [83:0] reg_game_M,
    input  logic [6:0]  play_made,
    output logic        S,
    output logic [2:0]  start_row, start_col,
    output logic [2:0]  end_row,   end_col
);

    logic [2:0] col, fila;
    logic player;
    logic [3:0] offset;

    logic [3:0] count_horiz, count_vert, count_diag1, count_diag2;
    logic win_horiz, win_vert, win_diag1, win_diag2;

    logic [2:0] start_row_tmp, start_col_tmp, end_row_tmp, end_col_tmp;

    assign player = play_made[6];
    assign col    = play_made[5:3];
    assign fila   = play_made[2:0];

    function automatic logic cell_matches(input logic [2:0] c, input logic [2:0] f);
        if (c > 6 || f > 5) return 0;
        return (reg_game_M[c*2 + f*14] && (reg_game_M[c*2 + f*14 + 1] == player));
    endfunction

    always_comb begin
        count_horiz = 1;
        count_vert  = 1;
        count_diag1 = 1;
        count_diag2 = 1;

        win_horiz = 0;
        win_vert  = 0;
        win_diag1 = 0;
        win_diag2 = 0;

        offset = 0;

        start_row_tmp = fila;
        start_col_tmp = col;
        end_row_tmp   = fila;
        end_col_tmp   = col;

        // Horizontal ↔
        for (int i = 1; i < 4; i++) if (col+i <= 6 && count_horiz < 4 && cell_matches(col+i, fila)) count_horiz++;
        for (int i = 1; i < 4; i++) if (col-i >= 0 && count_horiz < 4 && cell_matches(col-i, fila)) count_horiz++;
        win_horiz = (count_horiz >= 4);

        // Vertical ↓
        for (int i = 1; i < 4; i++) if (fila-i >= 0 && count_vert < 4 && cell_matches(col, fila-i)) count_vert++;
        win_vert = (count_vert >= 4);

        // Diagonal ↘
        for (int i = 1; i < 4; i++) if (col+i <= 6 && fila-i >= 0 && count_diag1 < 4 && cell_matches(col+i, fila-i)) count_diag1++;
        for (int i = 1; i < 4; i++) if (col-i >= 0 && fila+i <= 5 && count_diag1 < 4 && cell_matches(col-i, fila+i)) count_diag1++;
        win_diag1 = (count_diag1 >= 4);

        // Diagonal ↙
        for (int i = 1; i < 4; i++) if (col-i >= 0 && fila-i >= 0 && count_diag2 < 4 && cell_matches(col-i, fila-i)) count_diag2++;
        for (int i = 1; i < 4; i++) if (col+i <= 6 && fila+i <= 5 && count_diag2 < 4 && cell_matches(col+i, fila+i)) count_diag2++;
        win_diag2 = (count_diag2 >= 4);

        S = win_horiz | win_vert | win_diag1 | win_diag2;

        if (win_horiz) begin
            offset = 0;
            for (int i = 1; i < 4; i++) if (col-i >= 0 && cell_matches(col-i, fila)) offset++;
            start_col_tmp = col - offset;
            start_row_tmp = fila;
            end_col_tmp   = start_col_tmp + 3;
            end_row_tmp   = fila;
        end else if (win_vert) begin
            offset = 0;
            for (int i = 1; i < 4; i++) if (fila-i >= 0 && cell_matches(col, fila-i)) offset++;
            start_col_tmp = col;
            start_row_tmp = fila - offset;
            end_col_tmp   = col;
            end_row_tmp   = start_row_tmp + 3;
        end else if (win_diag1) begin
            offset = 0;
            for (int i = 1; i < 4; i++) if (col-i >= 0 && fila+i <= 5 && cell_matches(col-i, fila+i)) offset++;
            start_col_tmp = col - offset;
            start_row_tmp = fila + offset;
            end_col_tmp   = start_col_tmp + 3;
            end_row_tmp   = start_row_tmp - 3;
        end else if (win_diag2) begin
            offset = 0;
            for (int i = 1; i < 4; i++) if (col-i >= 0 && fila-i >= 0 && cell_matches(col-i, fila-i)) offset++;
            start_col_tmp = col - offset;
            start_row_tmp = fila - offset;
            end_col_tmp   = start_col_tmp + 3;
            end_row_tmp   = start_row_tmp + 3;
        end

        // Asignación final
        start_row = start_row_tmp;
        start_col = start_col_tmp;
        end_row   = end_row_tmp;
        end_col   = end_col_tmp;
    end
endmodule
