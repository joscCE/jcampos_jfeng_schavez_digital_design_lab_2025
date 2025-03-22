module Top_Calc #(parameter N = 4)(
    input logic [N-1:0] a, b,   // Entradas de 4 bits
    output logic [N-1:0] quotient,
    output logic [N-1:0] remainder_mod,
    output logic error_div,
    output logic error_mod,

    input logic cin,  
    output logic [N-1:0] r,       
	output logic cout
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

    // Resta
	top_sub #(.x(N)) restador_4bits (
		.a(a),      
		.b(b),      
		.cin(cin),  
		.r(r),      
		.cout(cout)
	);

endmodule
