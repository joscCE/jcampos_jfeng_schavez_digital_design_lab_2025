module connect_four (
    input logic clk,        // Reloj de 50 MHz de la FPGA
    input logic rst,        // Botón de reset
    output logic Hs, Vs,    // Señales de sincronización VGA
    output logic [7:0] R, G, B, // Salida de color VGA
	 output logic [9:0] Q_xz,
	 output logic [9:0] Q_yz
	 
);

    logic clk25;  // Reloj dividido a 25 MHz


    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            clk25 <= 0;
        else
            clk25 <= ~clk25;
    end

    // Instancia del controlador VGA
    Vga_Controller vga_inst (
        .clk(clk25),
        .rst(rst),
        .Hs(Hs),
        .Vs(Vs),
        .R(R),
        .G(G),
        .B(B),
		  .Q_xz(Q_xz),
		  .Q_yz(Q_yz)
    );

endmodule
