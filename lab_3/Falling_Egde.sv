
module Falling_Edge(
    input  logic clk,
    input  logic PS2_CLK,
    output logic ps2_clk_falling
);


logic ps2_clk_sync_0, ps2_clk_sync_1;

always_ff @(posedge clk) begin
    ps2_clk_sync_0 <= PS2_CLK;
    ps2_clk_sync_1 <= ps2_clk_sync_0;
end

// Detectar flanco de bajada (para lectura de datos del mouse)
assign ps2_clk_falling = (ps2_clk_sync_1 && !ps2_clk_sync_0);

endmodule