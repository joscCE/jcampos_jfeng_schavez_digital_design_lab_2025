module Top_Calc #(parameter N = 4)(
    input logic [N-1:0] a, b,   // Entradas de 4 bits
    output logic [N-1:0] quotient,
    output logic [N-1:0] remainder_mod,
    output logic error_div,
    output logic error_mod


);

	 // Señales para conectar con el módulo Multiplier
    logic [3:0] am, bm;
    logic [7:0] p;

    // Instancia del módulo Multiplier
    Multiplier uut (
        .a(am),
        .b(bm),
        .p(p)
    );
	 
	 // Señales para módulo Restador
	 logic cin;  
    logic [N-1:0] r;       
	 logic cout, Ne;

	 
	 // Resta
	top_sub #(.x(N)) restador_4bits (
		.a(a),      
		.b(b),      
		.cin(cin),  
		.r(r),      
		.cout(cout),
		.Ne(Ne)
	);


endmodule