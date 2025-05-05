module FSM_Mouse(
	input clk,
	input rst,
    input Start_Write,
    input Hold_Time,
    input wo,
    output en_reg_out,
	 output en_reg_lectura,
    output clk_oe,
    output data_oe,
    output shif_reg_lectura,
    output shift_reg_out,
    output rs_Count_write,
    output en_Count_write,
    output rst_Count_Hold_Time,
    output en_Count_Hold_Time,
    output [2:0] debug_state,
	 output rst_Counter_start



);

    logic [2:0] state, next_state;
    assign debug_state = state;
    // Estado actual
    always_ff @(posedge clk or posedge rst) begin    
        if (rst) 
            state <= 3'b000;
        else 
            state <= next_state;
    end

    // Lógica de siguiente estado
    always_comb begin
        next_state = state; // por default
        case (state)
            3'b000: next_state = (Start_Write & ~wo)? 3'b001: 3'b000; 
            3'b001: next_state =  Hold_Time? 3'b010: 3'b001;
            3'b010: next_state = 3'b011;
            3'b011: next_state = (wo)? 3'b000: 3'b011;
            default: next_state = 3'b000;
        endcase
    end
    
    assign clk_oe = (state == 3'b010)  | (state == 3'b001);
    
    assign data_oe = ((state == 3'b010) | (state == 3'b011)); 

    assign en_reg_out = (state == 3'b001) | (state == 3'b000);

    assign shif_reg_lectura = (state == 3'b000); 

    assign shift_reg_out = (state == 3'b011) & ~wo;

    assign rs_Count_write = 0;

    assign en_Count_write = (state == 3'b011) & ~wo; 

    assign rst_Count_Hold_Time = (state == 3'b000);
	 
    assign en_Count_Hold_Time = (state == 3'b001);
	 
	 assign en_reg_lectura = (state == 3'b000);

    assign rst_Counter_start = (state == 3'b001);



endmodule
