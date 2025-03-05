module tb_TopDecoder();
	logic [3:0] a;
	logic [7:0] seg1, seg0;
	
	TopDecoder  uut (.a(a), .seg1(seg1), .seg0(seg0));
	
	initial begin
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
        a = 4'b1010; #40;
        a = 4'b1011; #40;
        a = 4'b1100; #40;
		
	end


endmodule