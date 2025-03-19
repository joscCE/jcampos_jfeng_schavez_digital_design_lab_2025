module Top_Calc(
    input logic [3:0] a, b,   // Entradas de 4 bits
    output logic [3:0] quotient,
    output logic error        
);

    // Divisor
    top_div #(.N(4)) divisor_4bits (
        .dividend(a),
        .divisor(b),
        .quotient(quotient),
        .error(error) 
    );

endmodule
