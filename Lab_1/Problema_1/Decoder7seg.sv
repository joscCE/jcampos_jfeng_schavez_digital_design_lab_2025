module Decoder7seg (
	input logic [3:0] a,b,
	output logic [7:0] seg1, seg0
	
	assign seg0[7] = a[1] | a[3] |(~a[2] & ~a[0]) | (a[2]&a[0]);
	assign seg0[6] = ~a[2] | (a[1]&a[0]) | (~a[1] & ~a[0]);
	assign seg0[5] = ~a[1] | a[2] | a[0];
	assign seg0[4] = a[3] | (~a[2]&~a[0]) | (~a[2]&a[1]) | (a[1]&~a[0]) | (a[2] & ~a[1] & a[0]);
	assign seg0[3] = (~a[2]&~a[0]) | (a[1]&~a[0]);
	assign seg0[2] = a[3] | (a[2]&~a[0])|(~a[1]&~a[0]) | (a[2]&~a[1]);
	assign seg0[1] = a[3] | (~a[2]&a[1]) | (a[2]&~a[0]) | (a[2]&~a[1]);
	assign seg0[0] = 0;
	
	

);




endmodule