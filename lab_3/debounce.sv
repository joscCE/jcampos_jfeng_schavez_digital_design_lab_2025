module debounce #(
    parameter N = 8,                    // Número de señales de entrada
    parameter STABLE_CYCLES = 250000    // Número de ciclos estables requeridos
)(
    input  logic clk,                   // Reloj (por ejemplo, 25 MHz)
    input  logic rst,                   // Reset asincrónico activo en alto
    input  logic [N-1:0] noisy,         // Entradas con rebote (botones/switches)
    output logic [N-1:0] debounced      // Salidas filtradas
);

    // Contadores y estados estables para cada bit
    logic [$clog2(STABLE_CYCLES)-1:0] counter [N-1:0];
    logic [N-1:0] stable_state;

    genvar i;
    generate
        for (i = 0; i < N; i++) begin : debounce_loop
            always_ff @(posedge clk or posedge rst) begin
                if (rst) begin
                    counter[i]      <= 0;
                    stable_state[i] <= 0;
                end else begin
                    if (noisy[i] != stable_state[i]) begin
                        counter[i] <= counter[i] + 1;
                        if (counter[i] == STABLE_CYCLES - 1) begin
                            stable_state[i] <= noisy[i];
                            counter[i] <= 0;
                        end
                    end else begin
                        counter[i] <= 0;
                    end
                end
            end

            assign debounced[i] = stable_state[i];
        end
    endgenerate

endmodule