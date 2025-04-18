module debounce #(
    parameter N = 1,             // Número de botones
    parameter DIV_CNT = 17       // Tiempo de debounce (por default, 2^18 ciclos ≈ 10.5ms a 25MHz)
) (
    input clk,
    input [N-1:0] btn,           // Entradas de botones
    output [N-1:0] out           // Salidas debounced
);

    reg [DIV_CNT:0] clk_div [N-1:0];  // Contadores independientes por botón
    reg [N-1:0] out_reg;

    assign out = out_reg;

    integer i;
    always @(posedge clk) begin
        for (i = 0; i < N; i = i + 1) begin
            if (btn[i]) begin
                out_reg[i] <= 1'b1;
                clk_div[i] <= 0;
            end else if (clk_div[i][DIV_CNT]) begin
                out_reg[i] <= 1'b0;
                clk_div[i] <= 0;
            end else if (out_reg[i]) begin
                clk_div[i] <= clk_div[i] + 1'b1;
            end
        end
    end

endmodule


// referencia: https://github.com/njmarencik/debouncer