
module debounce #(
	parameter DIV_CNT = 17  // 2^18 = 262144 ciclos ≈ 10.5 ms a 25MHz
) (
	input clk,      
	input btn,      
	output out      
);

	reg [DIV_CNT:0] clk_div = 0;
	reg out_reg = 1'b0;

	assign out = out_reg;

	always @(posedge clk) begin
		if (btn) begin
			out_reg <= 1'b1;
			clk_div <= 0;
		end else if (clk_div[DIV_CNT]) begin
			out_reg <= 1'b0;
			clk_div <= 0;
		end else if (out_reg) begin
			clk_div <= clk_div + 1'b1;
		end
	end


endmodule

// referencia: https://github.com/njmarencik/debouncer