module Reg_Shift_Out #(parameter N = 10) (
    input logic clk,
    input logic rst,
    input logic [N-1:0] D,
    input logic en,
    input logic shf,
    output logic Q,
    output [N-1:0] Q_T
);

logic [N-1:0] Q_inter;

always_ff @(negedge clk or posedge rst) begin
    if (rst)
        Q_inter <= {N{1'b0}};
    else begin
        if (en)
            Q_inter <= D;
        else if (shf)
            Q_inter <= Q_inter >> 1;
    end
end

assign Q_T = Q_inter;

assign Q = Q_inter[0];

endmodule
