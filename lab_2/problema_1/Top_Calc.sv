
module Top_Calc(
	input logic [3:0] a, b,   
	input logic cin,          
	output logic [3:0] r,       
	output logic cout);    


	top_sub #(.x(4)) restador_4bits (
		.a(a),      
		.b(b),      
		.cin(cin),  
		.r(r),      
		.cout(cout)
	);

endmodule
