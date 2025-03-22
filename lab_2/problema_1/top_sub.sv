
module fullsubstract(
	input logic a,b,cin, 
	output logic r, cout);
	
	assign r = a ^ b ^ cin;						
	assign cout = (~a & cin) | (~a & b) | (cin & b);

	
endmodule 


module top_sub #(parameter x = 4)(
	input logic [x-1:0] a, b,
	input logic cin, 
	output logic [x-1:0] r,
	output logic cout);

	logic [x:0] borrow; 
	assign borrow[0] = cin;

	genvar i;
	generate
	  for (i = 0; i < x; i = i + 1) begin : sub_loop
			fullsubstract fs_unit (
				 .a(a[i]), 
				 .b(b[i]), 
				 .cin(borrow[i]), 
				 .r(r[i]), 
				 .cout(borrow[i+1])
			);
	  end
	endgenerate
	
	assign cout = borrow[x];
endmodule 