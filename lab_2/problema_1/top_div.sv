module top_div #(parameter N = 4) (
    input logic [N-1:0] dividend, 
    input logic [N-1:0] divisor,
    output logic [N-1:0] quotient,
    output logic error
);
    // Se extiende para evitar truncamientos
    logic [N:0] temp_dividend_ext;
    logic [N:0] divisor_ext;
    logic [N-1:0] temp_quotient;
    
    always_comb begin
        // Inicializar en 0
        temp_dividend_ext = {1'b0, dividend}; 
        divisor_ext      = {1'b0, divisor};
        temp_quotient    = 0;
        error = (divisor == 0);
        
        if (!error) begin
            for (int i = N-1; i >= 0; i = i - 1) begin
                if (temp_dividend_ext >= (divisor_ext << i)) begin
                    temp_dividend_ext = temp_dividend_ext - (divisor_ext << i);
                    temp_quotient[i] = 1;
                end
            end
        end
        
        quotient = temp_quotient;
    end
endmodule
