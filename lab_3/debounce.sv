module debounce #(
    parameter N = 1,             // Número de botones
    parameter DIV_CNT = 17       // Tiempo de debounce (por default, 2^18 ciclos ≈ 10.5ms a 25MHz)
) (
    input clk,
    input [N-1:0] btn,           // Entradas de botones
    output [N-1:0] out           // Pulsos de 1 ciclo por pulsación
);

    reg [DIV_CNT:0] clk_div [N-1:0];  // Contadores independientes por botón
    reg [N-1:0] btn_sync;
    reg [N-1:0] btn_prev;
    reg [N-1:0] out_reg;

    assign out = out_reg;

    integer i;
    always @(posedge clk) begin
        for (i = 0; i < N; i = i + 1) begin
            btn_sync[i] <= btn[i];

            // Detecta flanco de subida limpio
            if (btn_sync[i] && !btn_prev[i]) begin
                out_reg[i] <= 1'b1;     // Genera pulso
                clk_div[i] <= 0;        // Reinicia contador
            end else begin
                out_reg[i] <= 1'b0;     // Pulso solo un ciclo
            end

            // Mientras el botón esté presionado, sigue contando
            if (btn_sync[i]) begin
                clk_div[i] <= clk_div[i] + 1'b1;
            end

            // Actualizar estado previo 
            if (clk_div[i][DIV_CNT]) begin
                btn_prev[i] <= btn_sync[i];
            end
        end
    end

endmodule



// referencia: https://github.com/njmarencik/debouncer