module FSM_Mouse(
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
    output logic mode_sum_y
);

    logic [2:0] state, next_state;

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
            3'b000: begin
                if (BO) 
                    next_state = 3'b001;
                else if (B1) 
                    next_state = 3'b010;
                else if (B2) 
                    next_state = 3'b100;
                else 
                    next_state = 3'b000;
            end
            3'b001: next_state = Bit_Out ? 3'b011 : 3'b001;
            3'b010: next_state = Bit_Out ? 3'b011 : 3'b010;
            3'b100: next_state = Bit_Out ? 3'b011 : 3'b100;
            3'b011: next_state = Byte_Out ? 3'b101 : 3'b000;
            3'b101: next_state = 3'b000;
            default: next_state = 3'b000;
        endcase
    end

    // Lógica de salidas
    assign rst_Bit_Counter = (state == 3'b000);
    assign rst_Byte_Counter = (state == 3'b101);
    assign en_Reg_Status = (state == 3'b001);
    assign en_Reg_DX = (state == 3'b010);
    assign en_Reg_DY = (state == 3'b100);
    assign shft_Status = (state == 3'b001);
    assign shft_DX = (state == 3'b010);
    assign shft_DY = (state == 3'b100);
    assign en_Sumandor = (state == 3'b101);
    assign mode_sum_X = sig_x;
    assign mode_sum_y = sig_y;
    assign en_Bit_Counter = (state ==3'001) | (state == 3'010) | (state == 3'100); 
    assign en_Byte_Counter = (state == 3'011);
   assign en_Reg_Y_pos = (state == 3'101);
   assign en_Reg_X_pos = (state == 3'101);


endmodule
