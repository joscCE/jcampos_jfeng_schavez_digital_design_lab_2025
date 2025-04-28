module Shift_Reg #(parameter N = 10) (
    input clk,
    input rst,
    input D,
    input en,
    input shf,
    output logic [N-1:0] Q
);

always_ff @(negedge clk or posedge rst) begin
    if (rst)
        Q <= '0;
    else if (en && shf)
        Q <= {D, Q[N-1:1]};
end

endmodule