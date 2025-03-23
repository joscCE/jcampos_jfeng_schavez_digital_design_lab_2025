module Multiplier #(parameter N = 4) (
    input logic [N-1:0] a, b,
    output logic [N-1:0] p,   
    output logic v           
);

    logic [N-1:0] partials [0:N-1];
    genvar i, j;
    
    generate
        for (i = 0; i < N; i++) begin : partial_product_gen
            for (j = 0; j < N; j++) begin : and_gen
                assign partials[i][j] = a[i] & b[j]; 
            end
        end
    endgenerate

    logic [(2*N)-1:0] shifted_partial [0:N-1];
    
    generate
        for (i = 0; i < N; i++) begin : shift_gen
            assign shifted_partial[i] = {{(N){1'b0}}, partials[i]} << i;
        end
    endgenerate
    
    logic [(2*N)-1:0] sum[N-1:0];
    
    assign sum[0] = shifted_partial[0];
    
    generate
        for (i = 1; i < N; i++) begin : adder_gen
            assign sum[i] = sum[i-1] + shifted_partial[i];
        end
    endgenerate
    
    assign p = sum[N-1][N-1:0];  
    assign v = |sum[N-1][2*N-1:N];  

endmodule
