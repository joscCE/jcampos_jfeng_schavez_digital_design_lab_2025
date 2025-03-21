module Top_Calc #(parameter N = 4)(
    input logic [N-1:0] a, b,   // Entradas de 4 bits
    output logic [N-1:0] quotient,
    output logic [N-1:0] remainder_mod,
    output logic error_div,
    output logic error_mod
);

    // División
    top_div #(.N(N)) divisor_4bits (
        .dividend(a),
        .divisor(b),
        .quotient(quotient),
        .error(error_div)
    );

    // Módulo
    top_mod #(.N(N)) mod_4bits (
        .dividend(a),
        .divisor(b),
        .remainder(remainder_mod),
        .error(error_mod)
    );

endmodule
