module tb_decoder7seg();
	logic [3:0] b, a;
	logic [7:0] seg1, seg0;
	
	Decoder7seg uut (.a(a), .b(b), .seg1(seg1), .seg0(seg0));
	
	initial begin
			b = 4'b0001;
        a = 4'b0000; #40;
        a = 4'b0001; #40;
        a = 4'b0010; #40;
        a = 4'b0011; #40;
        a = 4'b0100; #40;
        a = 4'b0101; #40;
        a = 4'b0110; #40;
        a = 4'b0111; #40;
        a = 4'b1000; #40;
        a = 4'b1001; #40;

		
	end
	
	
endmodule