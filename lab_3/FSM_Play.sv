module FSM_Play(
    input rst, change_turn, comp_turn, comp_left, comp_Right, L, R, P, clk,
    output en_count_column, Mode_Count_Column, rst_timer, en_turn, rst_turn
);

    logic [2:0] state, next_state; // Cambié [0:6] por [2:0] que es lo correcto

    // Flip-flop de estado
    always_ff @(posedge clk or posedge rst)
        if (rst)
            state <= 3'b000;
        else
            state <= next_state;

    // Lógica del próximo estado
    always_comb begin
        case(state)
            3'b000: begin
                if (L)
                    next_state = 3'b010;
                else if (R)
                    next_state = 3'b001;
                else if (P)
                    next_state = 3'b101;
                else
                    next_state = 3'b000;
            end
            3'b001: next_state = comp_left  ? 3'b000 : 3'b011;
            3'b010: next_state = comp_Right ? 3'b000 : 3'b100;
            3'b011: next_state = 3'b000;
            3'b100: next_state = 3'b000;
            3'b101: next_state = change_turn ? 3'b110 : 3'b101;
            3'b110: next_state = 3'b000;
            default: next_state = 3'b000;
        endcase
    end

    // Salidas
    assign en_count_column    = (state == 3'b011) || (state == 3'b100);
    assign Mode_Count_Column  = (state == 3'b011);
    assign rst_timer          = (state == 3'b110);
    assign en_turn            = (state == 3'b110) && (!comp_turn); // corregido XOR raro
    assign rst_turn           = comp_turn;

endmodule
