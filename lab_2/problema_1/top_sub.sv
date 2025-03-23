
module fullsubstract(
	input logic a,b,cin, 
	output logic r, cout);
	
	assign r = a ^ b ^ cin;						
	assign cout = (~a & cin) | (~a & b) | (cin & b);

	
endmodule 


module top_sub #(parameter N = 4)(
	input logic [N-1:0] a, b,
	input logic cin, 
	output logic [N-1:0] r,
	output logic cout, Ne
);

	logic [N:0] borrow; 
	assign borrow[0] = cin;
	assign Ne = (b > a); // Si es negativo o no

	logic [N-1:0] a_new, b_new;
	assign a_new = (Ne) ? b : a;
	assign b_new = (Ne) ? a : b;

	genvar i;
	generate
	  for (i = 0; i < N; i = i + 1) begin : sub_loop
			fullsubstract fs_unit (
				 .a(a_new[i]), 
				 .b(b_new[i]), 
				 .cin(borrow[i]), 
				 .r(r[i]), 
				 .cout(borrow[i+1])
			);
	  end
	endgenerate
	
	assign cout = borrow[N];
endmodule 