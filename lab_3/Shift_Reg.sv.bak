module Shift_Reg #(parameter N = 10) (

	input clk, rst,
	input [N-1:0] D,
	input en,
    input shf,
	output logic [N-1:0] Q

);

always_ff @(negedge clk or posedge rst) begin
    if (rst)
        Q <= '0; 
    else if (en)
        Q <= D;   
    else if (shf)
        Q <= Q << 1; 
end


endmodule 