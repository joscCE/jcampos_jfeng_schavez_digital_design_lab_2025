module tb_connect_four;

  // Inputs
  logic clk, rst;
  logic [2:0] player0, player1;
  logic p0, p1, start;

  // Outputs
  logic Hs, Vs;
  logic VGA_Blank, VGA_Sync_N, VGA_CLK;
  logic [7:0] R, G, B;
  
  logic [2:0] debug_colum;


  // Instancia del DUT
  connect_four dut (
    .clk(clk),
    .rstin(rst),
    .player0in(player0),
    .player1in(player1),
    .p0in(p0),
    .p1in(p1),
    .startin(start),
    .Hs(Hs), .Vs(Vs),
    .VGA_Blank(VGA_Blank), .VGA_Sync_N(VGA_Sync_N), .VGA_CLK(VGA_CLK),
    .R(R), .G(G), .B(B),
	 .debug_colum(debug_colum)
  );

  // Clock
  always #10 clk = ~clk;

  // Test sequence
  initial begin
    $display("Inicio del Testbench");

    // Inicialización
    clk = 0;
    rst = 0;
    p0 = 1; p1 = 1; start = 1;
    player0 = 3'b111;  // Solo Play activo
    player1 = 3'b111;

    #50;
    rst = 1;

    // Esperamos algunos ciclos
    #100;
    // Empezamos el juego
    start = 0; #100;
    start = 1;

    // Esperamos que el FSM pase a estado 3
    #200;

    // Simulamos una jugada (p0)


    // Simulamos una jugada de player0
    player0 = 3'b101; // Play
    #200;
	 
	 player0 = 3'b111; // Play
    #200;
	 
	  player0 = 3'b101; // Play
    #200;
	 
	 player0 = 3'b111; // Play
    #1000;
	 

	 
    // Fin del test
    $finish;
  end

endmodule
