
module FSM (
	input clk, rst, L, R, time_out, winning, valid_play, play, start,
	input comp_right, comp_left, comp_random,
	input p1, p0,
	output rst_timer, rst_turn, rst_game, rst_random, rst_column,
	output en_turn, en_count_column, en_random_play, en_new_game, en_reg_selection,
	output mode_count_column, play_selection, en_turn_timer,
	output logic [1:0] display_select,
	output logic [3:0] state_debug
	
);

// Logica de estado actual

	logic [3:0] state, next_state;
	assign state_debug = state;

	always_ff @(posedge clk or posedge rst)
		if(rst) state <= 4'b0000;
		else
		 state <= next_state;
		 
// Logica de siguiente estado

	always_comb begin 
	next_state <= 4'b0000;
		case (state)
			4'b0000: begin
					if (p0) 
						next_state <= 4'b0001;
					else if (p1)
						next_state <= 4'b0010;
					else if (start)
						next_state <= 4'b0011;
					else 
						next_state <= 4'b0000;
				end 
			4'b0001: next_state <= 4'b0000;
			4'b0010: next_state <= 4'b0000;
			4'b0011: begin
					if (R)
						next_state <= 4'b1001;
					else if (L)
						next_state <= 4'b0011;
					else if (time_out)
						next_state <= 4'b0100;
					else if (play) 
						next_state <= 4'b0101;
					else
						next_state <= 4'b0011;
				end 
			4'b0100: next_state <= 4'b0101;
			4'b0101: next_state <= valid_play? 4'b0110 : 4'b0011;
			4'b0110: next_state <= winning? 4'b0111 : 4'b1000;
			4'b0111: next_state <= rst? 4'b0000 : 4'b0111;
			4'b1000: next_state <= 4'b0011;
			4'b1001: next_state <= comp_right? 4'b0011 : 4'b1010;
			4'b1010: next_state <= 4'b0011;
			4'b1011: next_state <= comp_left? 4'b0011 : 4'b1100;
			4'b1100: next_state <= 4'b0011;
			default: next_state <= 4'b0000;
		endcase 
	end
	
// Logica output

	assign rst_timer = (state == 4'b1000);
	assign en_turn_timer = (state == 4'b0011);
	
	
	assign rst_game = (state == 4'b0111) && rst;
	assign rst_random = comp_random;
	
	assign en_turn = ((state == 4'b1000) | (state==4'b0010) | (state==4'b0001));
	assign en_count_column = (state == 4'b1010);
	assign en_random_play = ~(state==4'b0101);
	assign en_new_game = (state == 4'b0110);
	assign en_reg_selection = (state == 4'b0011) | (state == 4'b0100) ;
	assign rst_column = (state == 4'b1000) | comp_right;
	
	assign mode_count_column = (state == 4'b1010);
	assign play_selection = ~(state == 4'b0100);
	
always_comb begin
    if (state != 4'b0000 && state != 4'b0111) begin
        display_select = 2'b00; // valor que desees cuando no es ni 0 ni 7
    end else begin
        case (state)
            4'b0000: display_select = 2'b01;
            4'b0111: display_select = 2'b10;
            default: display_select = 2'b01; // valor por defecto
        endcase
    end
end


endmodule 