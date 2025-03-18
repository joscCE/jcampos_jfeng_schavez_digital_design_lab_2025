
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
	output logic cout,
	output logic N, Z, C, V);

	logic [x:0] borrow; 
	assign borrow[0] = cin;

	logic [x-1:0] r_temp, r_abs;	

	genvar i;
	generate
	  for (i = 0; i < x; i = i + 1) begin : sub_loop
			fullsubstract fs_unit (
				 .a(a[i]), 
				 .b(b[i]), 
				 .cin(borrow[i]), 
				 .r(r_temp[i]), 
				 .cout(borrow[i+1])
			);
	  end
	endgenerate
	
	assign cout = borrow[x];
	
	assign N = r[x-1];
	assign Z = (r == 0);
	assign C = cout;
	assign V = (a[x-1] != b[x-1]) && (a[x-1] != r[x-1]);

endmodule 