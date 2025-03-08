module Top_Sub 
	#(parameter N=6)
	(
	input logic [N-1:0] a,
	input logic reset,
	input logic dec_btn,
	output logic [7:0] seg1, seg0
	);
	
	reg [N-1:0] value;
	
	// reset
	always_ff @(posedge reset)
		if (reset) 
			value <= a;
	
	// decremento 
	always_ff @(posedge dec_btn)  
		if(dec_btn) 
			value <= value - 1'b1;
		
endmodule 
