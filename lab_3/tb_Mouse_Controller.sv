`timescale 1ns/1ps

module tb_Mouse_Controller;

  // Entradas
  reg PS2_CLK;
  reg PS2_DAT;
  reg rst;
  
  // Salidas
  wire [15:0] Mouse_CoordsX;
  wire [15:0] Mouse_CoordsY;
  wire [1:0] debug_state;
  wire [3:0] debug_bit_counter;
  wire [1:0] debug_byte_counter;
  wire [7:0] debug_status, debug_dx, debug_dy;

  // Instancia del módulo
  Mouse_Controller uut (
    .PS2_CLK(PS2_CLK),
    .PS2_DAT(PS2_DAT),
    .rst(rst),
    .Mouse_CoordsX(Mouse_CoordsX),
    .Mouse_CoordsY(Mouse_CoordsY),
    .debug_state(debug_state),
    .debug_bit_counter(debug_bit_counter),
    .debug_byte_counter(debug_byte_counter),
    .debug_status(debug_status),
    .debug_dx(debug_dx),
    .debug_dy(debug_dy)
  );

  // Clock de prueba para PS2 (emula el reloj del protocolo PS/2)
  initial begin
    PS2_CLK = 1;
    forever #50 PS2_CLK = ~PS2_CLK; // Periodo de 100ns => 10MHz clock
  end

  // Tarea para enviar un byte en formato PS/2
  task send_ps2_byte(input [7:0] data);
    integer i;
    begin
      // START bit (always 0)
      PS2_DAT = 0;
      @(negedge PS2_CLK);

      // 8 data bits (LSB first)
      for (i = 0; i < 8; i = i + 1) begin
        PS2_DAT = data[i];
        @(negedge PS2_CLK);
      end

      // PARITY bit (odd parity)
      PS2_DAT = ~(^data); // Odd parity
      @(negedge PS2_CLK);

      // STOP bit (always 1)
      PS2_DAT = 1;
      @(negedge PS2_CLK);
    end
  endtask

  // Prueba principal
  initial begin
    // Inicializa señales
    rst = 1;
    PS2_DAT = 1;

    // Reset
    #200;
    rst = 0;
    #200;

    // Simular el envío de un paquete de 3 bytes
    // Por ejemplo:
    // status = 8'b00001000 (sin clics, x positivo, y negativo)
    // dx = 8'd5
    // dy = 8'd10

    send_ps2_byte(8'b00001000); // Status byte
    send_ps2_byte(8'd5);        // dx byte
    send_ps2_byte(8'd10);
	 send_ps2_byte(8'b00001000); // Status byte
	 send_ps2_byte(8'd5); 
	 send_ps2_byte(8'd10);
    // Esperar a que procese
    #2000;

    $display("Mouse_CoordsX: %d", Mouse_CoordsX);
    $display("Mouse_CoordsY: %d", Mouse_CoordsY);

    $finish;
  end

endmodule
