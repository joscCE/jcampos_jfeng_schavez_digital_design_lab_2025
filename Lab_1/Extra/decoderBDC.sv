module decoderBDC(
	input logic [3:0] a,
	output logic [3:0] y1, y0

);
	
	/* output first segmen */
	assign y0[0] = a[0];
	assign y0[1] = (~a[3] & a[1] )| (a[3] & a[2] & ~a[1]);
	assign y0[2] = (~a[3] & a[2]) | (a[2] & a[1] );
	assign y0[3] = a[3]&~a[2]&~a[1];
	
	/* output second segmen */
	assign y1[0] = (a[3] & a[2]) | (a[3] & a[1]);
	assign y1[1] = 0;
	assign y1[2] = 0;
	assign y1[3] = 0;
	

endmodule