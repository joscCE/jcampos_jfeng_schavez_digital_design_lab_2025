module PS2_Synchronizer (
    input  logic clk,             // Reloj del sistema (por ejemplo 50MHz)
    input  logic ce,              // Clock enable para PS2_CLK
    input  logic de,              // Clock enable para PS2_DAT
    input  logic PS2_CLK,         // Señal cruda desde el mouse (clock)
    input  logic PS2_DAT,         // Señal cruda desde el mouse (data)
    output logic ps2_clk_falling, // Pulso de flanco de bajada sincronizado
    output logic ps2_clk_in,      // PS2_CLK sincronizado (2 FFs)
    output logic ps2_dat_in       // PS2_DAT sincronizado (2 FFs)
);

    logic ps2_clk_syn0, ps2_clk_syn1;
    logic ps2_dat_syn0, ps2_dat_syn1;

    // Asignaciones combinacionales con ce/de
    assign ps2_clk_syn0 = ce ? 1'b1 : PS2_CLK;
    assign ps2_dat_syn0 = de ? 1'b1 : PS2_DAT;

    // Sincronización (dos flip-flops)
    always_ff @(posedge clk) begin
        ps2_clk_syn1 <= ps2_clk_syn0;
        ps2_clk_in   <= ps2_clk_syn1;

        ps2_dat_syn1 <= ps2_dat_syn0;
        ps2_dat_in   <= ps2_dat_syn1;
    end

    // Detección de flanco de bajada del clock PS/2
    assign ps2_clk_falling = (ps2_clk_syn1 && !ps2_clk_syn0);

endmodule
