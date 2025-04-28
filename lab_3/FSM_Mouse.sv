module FSM_Mouse(
	input Data,
    input BO,
    input B1,
    input B2,
    input Byte_Out,
    input Bit_Out,
    input sig_x,
    input sig_y,
    input clk,
    input rst, 
	

	
    output logic rst_Bit_Counter,
    output logic rst_Byte_Counter,
    
    output logic en_Bit_Counter,
    output logic en_Byte_Counter,
	 
    output logic en_Reg_Status,
    output logic en_Reg_DX,

    output logic en_Reg_X_pos,
    output logic en_Reg_Y_pos,


    output logic en_Reg_DY,
	 
    output logic shft_Status,
    output logic shft_DX,
    output logic shft_DY,
	 
    output logic en_Sumandor,
    output logic mode_sum_X,
    output logic mode_sum_y,
	 output logic [1:0] debug_state
);

    logic [1:0] state, next_state;

    // Estado actual
    always_ff @(negedge clk or posedge rst) begin
        if (rst) 
            state <= 2'b00;
        else 
            state <= next_state;
    end

    // Lógica de siguiente estado
    always_comb begin
        next_state = state; // por default
        case (state)
            2'b00: next_state = Data? 2'b00: 2'b01; 
            2'b01: next_state = Bit_Out ? 2'b10 : 2'b01;
				2'b10: next_state = 2'b00;
            default: next_state = 2'b00;
        endcase
    end

    // Lógica de salidas

	
	assign debug_state = state;
	
	
	assign en_Reg_Status = BO & ~Bit_Out & (state==2'b01);
	assign en_Reg_DY = B2 & ~Bit_Out  & (state==2'b01);
	assign en_Reg_DX = B1 & ~Bit_Out  & (state==2'b01);
	
	assign shft_Status = BO & ~Bit_Out;
	assign shft_DY = B2 & ~Bit_Out;
	assign shft_DX = B1 & ~Bit_Out;
	
	
	assign rst_Bit_Counter = (state==2'b00);
	assign en_Reg_X_pos = B2 & (state==2'b10);
	assign en_Reg_Y_pos = B2 & (state==2'b10);
	assign en_Sumandor =  B2 & (state==2'b10);
	
	
	assign rst_Byte_Counter = Byte_Out & (state==2'b00);
	
	assign en_Bit_Counter = (state == 2'b01);
	assign en_Byte_Counter = (state == 2'b10);

	
	
	assign mode_sum_X = sig_x;
	assign mode_sum_y = sig_y; 
	
endmodule
