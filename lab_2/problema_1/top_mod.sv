module top_mod #(parameter N = 4) (
    input logic [N-1:0] a,       // Antes: dividend
    input logic [N-1:0] b,       // Antes: divisor
    output logic [N-1:0] r,      // Antes: remainder
    output logic err             // Antes: error
);
    logic [N:0] temp_a_ext;
    logic [N:0] b_ext;

    always_comb begin
        // Inicialización en 0
        temp_a_ext = {1'b0, a};
        b_ext = {1'b0, b};
        err = (b == 0); // Verificar si el divisor es 0

        if (!err) begin
            // Cálculo del módulo usando desplazamiento
            for (int i = N-1; i >= 0; i = i - 1) begin
                if (temp_a_ext >= (b_ext << i)) begin
                    temp_a_ext = temp_a_ext - (b_ext << i);
                end
            end
        end

        r = temp_a_ext[N-1:0]; // El residuo se obtiene de los N bits menos significativos
    end
endmodule
