module tb_Mouse_Controller;

  reg clk = 0;
  reg rst = 1;

  wire PS2_DAT;
  wire PS2_CLK;

  wire [15:0] Mouse_CoordsX, Mouse_CoordsY;
  wire [2:0] debug_state;
  wire [3:0] debug_bit_counter;
  wire [1:0] debug_byte_counter;
  wire [7:0] debug_status, debug_dx, debug_dy;

  // Drivers (bidireccionales simulados)
  reg ps2_clk_drv = 1;
  reg ps2_dat_drv = 1;

  assign PS2_CLK = ps2_clk_drv ? 1'bz : 1'b0;
  assign PS2_DAT = ps2_dat_drv ? 1'bz : 1'b0;

  Mouse_Controller dut (
    .clk(clk),
    .rst(rst),
    .PS2_CLK(PS2_CLK),
    .PS2_DAT(PS2_DAT),
    .Mouse_CoordsX(Mouse_CoordsX),
    .Mouse_CoordsY(Mouse_CoordsY),
    .debug_state(debug_state),
    .debug_bit_counter(debug_bit_counter),
    .debug_byte_counter(debug_byte_counter),
    .debug_status(debug_status),
    .debug_dx(debug_dx),
    .debug_dy(debug_dy)
  );

  // Clock 50 MHz
  always #10 clk = ~clk;

  // Task alternativa para Verilog puro
  task simulate_ps2_clk_pulses;
    input integer count;
    integer i;
    begin
      for (i = 0; i < count; i = i + 1) begin
        #2 ps2_clk_drv = 0;
        #2 ps2_clk_drv = 1;
        #20;
      end
    end
  endtask

  integer bit_index;
  reg [10:0] transmitted_bits;

  initial begin
    #100;
    rst = 0;

    // Liberamos DAT
    ps2_dat_drv = 1;

    // Esperamos a que entre al estado 4
    wait (debug_state == 3'b100);
    $display(">> Estado 4 detectado: comenzando captura...");

    bit_index = 0;

    while (bit_index < 11) begin
      ps2_clk_drv = 0;
      #2;
      $display("Bit %0d transmitido: %b", bit_index, PS2_DAT);
      transmitted_bits[bit_index] = PS2_DAT;
      bit_index = bit_index + 1;
      ps2_clk_drv = 1;
      #20;
    end

    $display("Bits capturados: %b", transmitted_bits);

    if (transmitted_bits[8:1] == 8'hF4 && transmitted_bits[0] == 0 && transmitted_bits[10] == 1)
      $display("✅ Comando F4 enviado correctamente.");
    else
      $display("❌ Error en el comando enviado.");

    $stop;
  end

endmodule
