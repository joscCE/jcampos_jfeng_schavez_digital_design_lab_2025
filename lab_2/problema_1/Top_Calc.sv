module Top_Calc #(parameter N = 4) (
    input logic [N-1:0] dividend,
    input logic [N-1:0] divisor,
    output logic [N-1:0] remainder_mod,
    output logic error_mod
);

    // modulo
    top_mod #(.N(N)) mod_inst (
        .dividend(dividend),
        .divisor(divisor),
        .remainder(remainder_mod),
        .error(error_mod)
    );

endmodule
