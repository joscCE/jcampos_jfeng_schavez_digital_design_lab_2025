module connect_four (
    input logic clk,        // Reloj de 50 MHz de la FPGA
    input logic rst,        // Botón de reset
    output logic Hs, Vs,
	 output logic VGA_Blank, VGA_Sync_N, VGA_CLK, 
    output logic [7:0] R, G, B
);

    logic clk25;  // Reloj dividido a 25 MHz
	 logic rst_active;
	 
	 assign rst_active = ~rst;
	 assign VGA_CLK = clk25;

    always_ff @(posedge clk or posedge rst_active) begin
        if (rst_active)
            clk25 <= 0;
        else
            clk25 <= ~clk25;
    end
	 

    // Instancia del controlador VGA
    Vga_Controller vga_inst (
        .clk(clk25),
        .rst(rst_active),
        .Hs(Hs),
        .Vs(Vs),
        .R(R),
        .G(G),
        .B(B),
		  .VGA_Blank(VGA_Blank),
		  .VGA_Sync_N(VGA_Sync_N)
    );

endmodule
