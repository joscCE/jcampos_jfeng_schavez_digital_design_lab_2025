module top_mod #(parameter N = 4) (
    input logic [N-1:0] dividend, 
    input logic [N-1:0] divisor,
    output logic [N-1:0] remainder,
    output logic error
);
    logic [N:0] temp_dividend_ext;
    logic [N:0] divisor_ext;

    always_comb begin
        // Inicialización en 0
        temp_dividend_ext = {1'b0, dividend};
        divisor_ext = {1'b0, divisor};
        error = (divisor == 0); // Verificar si divisor es 0

        if (!error) begin
            //Calculo del modulo usando desplazamiento
            for (int i = N-1; i >= 0; i = i - 1) begin
                if (temp_dividend_ext >= (divisor_ext << i)) begin
                    temp_dividend_ext = temp_dividend_ext - (divisor_ext << i);
                end
            end
        end

        remainder = temp_dividend_ext[N-1:0]; // El residuo se obtiene de los N bits menos significativos
    end
endmodule
