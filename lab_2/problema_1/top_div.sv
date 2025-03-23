module top_div #(parameter N = 4) (
    input logic [N-1:0] a,       // Antes: dividend
    input logic [N-1:0] b,       // Antes: divisor
    output logic [N-1:0] d,      // Antes: quotient
    output logic err             // Antes: error
);
    // Se extiende para evitar truncamientos
    logic [N:0] temp_a_ext;
    logic [N:0] b_ext;
    logic [N-1:0] temp_d;
    
    always_comb begin
        // Inicializar en 0
        temp_a_ext = {1'b0, a}; 
        b_ext      = {1'b0, b};
        temp_d     = 0;
        err = (b == 0); // Error si el divisor es 0
        
        if (!err) begin
            for (int i = N-1; i >= 0; i = i - 1) begin
                if (temp_a_ext >= (b_ext << i)) begin
                    temp_a_ext = temp_a_ext - (b_ext << i);
                    temp_d[i] = 1;
                end
            end
        end
        
        d = temp_d;
    end
endmodule