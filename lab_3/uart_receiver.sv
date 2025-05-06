module uart_receiver #(
    parameter CLK_PER_BIT = 434  // Para 25MHz y 57600 baudios
)(
    input  logic clk,
    input  logic rst,
    input  logic rx,
    output logic [7:0] data_out,
    output logic data_valid
);

    typedef enum logic [1:0] {
		IDLE, 
		START, 
		DATA, 
		STOP} state_t;
		
    state_t state = IDLE;

    logic [8:0] clk_cnt = 0;
    logic [2:0] bit_idx = 0;
    logic [7:0] shift = 0;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            clk_cnt <= 0;
            bit_idx <= 0;
            shift <= 0;
            data_out <= 0;
            data_valid <= 0;
        end else begin
            data_valid <= 0;
				
            case (state)
                IDLE: if (!rx) begin
                    state <= START;
                    clk_cnt <= 0;
                end

                START: begin
                    clk_cnt <= clk_cnt + 1;
                    if (clk_cnt == CLK_PER_BIT/2) begin
                        if (!rx) begin
                            clk_cnt <= 0;
                            bit_idx <= 0;
                            state <= DATA;
                        end else state <= IDLE;
                    end
                end

                DATA: begin
                    clk_cnt <= clk_cnt + 1;
                    if (clk_cnt == CLK_PER_BIT) begin
                        clk_cnt <= 0;
                        shift[bit_idx] <= rx;
                        if (bit_idx == 7)
                            state <= STOP;
                        else
                            bit_idx <= bit_idx + 1;
                    end
                end

                STOP: begin
                    clk_cnt <= clk_cnt + 1;
                    if (clk_cnt == CLK_PER_BIT) begin
                        if (rx) begin
                            data_out <= shift;
                            data_valid <= 1;
                        end
                        state <= IDLE;
                        clk_cnt <= 0;
                    end
                end
            endcase
        end
    end

endmodule
