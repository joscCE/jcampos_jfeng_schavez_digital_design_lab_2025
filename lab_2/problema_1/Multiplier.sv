module Multiplier (
    input logic [3:0] a, b,
    output logic [7:0] p
);

    
    logic [3:0] partials [0:3];

    
    genvar i, j;
    generate
        for (i = 0; i < 4; i++) begin : partial_product_gen
            for (j = 0; j < 4; j++) begin : and_gen
                assign partials[i][j] = a[i] & b[j]; 
            end
        end
    endgenerate

    
    logic [7:0] shifted_partial [0:3];

    generate
        for (i = 0; i < 4; i++) begin : shift_gen
            assign shifted_partial[i] = {partials[i], {i{1'b0}}}; 
        end
    endgenerate


    logic [7:0] sum1, sum2, final_product;


    FullAdder FA0 (
        .a(shifted_partial[0]), 
        .b(shifted_partial[1]), 
        .cin(0),
        .s(sum1), 
        .cout()
    );

    FullAdder FA1 (
        .a(sum1), 
        .b(shifted_partial[2]), 
        .cin(0),
        .s(sum2), 
        .cout()
    );

    FullAdder FA2 (
        .a(sum2), 
        .b(shifted_partial[3]), 
        .cin(0),
        .s(final_product), 
        .cout()
    );

    assign p = final_product; 

endmodule
