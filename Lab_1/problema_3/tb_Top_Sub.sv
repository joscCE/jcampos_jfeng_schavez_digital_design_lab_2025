`timescale 1ns / 1ps

module tb_Top_Sub;

  parameter N = 6;
  
  // Señales del DUT
  logic [N-1:0] a;
  logic reset;
  logic dec_btn;
  logic [7:0] seg1, seg0;
  logic [N-1:0] value_internal;  // Señal interna para monitorizar 'value'

  // Instancia del DUT
  Top_Sub #(.N(N)) dut (
    .a(a),
    .reset(reset),
    .dec_btn(dec_btn),
    .seg1(seg1),
    .seg0(seg0)
  );

  // Variable para el valor esperado
  logic [N-1:0] expected_value;

  // Generación de un valor aleatorio
  initial begin
    a = 100111;  // 15
    expected_value = a;  // El valor inicial de 'value' debe ser 'a'

    // Inicialización
    reset = 1;      // Aplicar reset
    dec_btn = 1;    // Botón inactivo
    #10;
    
    // Desactivar el reset para cargar el valor en 'value'
    reset = 0;      // Liberar reset (reset = 0 significa presionar)
    #10;
	 
	 reset = 1;
	 #10;
    
    // Verificar si el valor cargado es el esperado (a)
    if (dut.value !== expected_value) begin
      $display("ERROR: El valor de 'value' no es el esperado después del reset inicial.");
      $stop;  // Detener simulación si el valor no es correcto
    end else begin
      $display("Valor inicial de 'value' correcto: %d", dut.value);
    end
    
    // Prueba de decremento: decrecer tres veces
    dec_btn = 0;    // Activar botón para decrecer (dec_btn = 0 significa presionar)
    #10;
    dec_btn = 1;    // Liberar botón
    #10;
    
    // Verificar después del primer decremento
    if (dut.value !== (expected_value - 1)) begin
      $display("ERROR: El valor de 'value' no es el esperado después del primer decremento.");
      $stop;
    end
    
    // Decremento 2
    dec_btn = 0;    // Decremento 2
    #10;
    dec_btn = 1;
    #10;
    
    // Verificar después del segundo decremento
    if (dut.value !== (expected_value - 2)) begin
      $display("ERROR: El valor de 'value' no es el esperado después del segundo decremento.");
      $stop;
    end
    
    // Decremento 3
    dec_btn = 0;    // Decremento 3
    #10;
    dec_btn = 1;
    #10;
    
    // Verificar después del tercer decremento
    if (dut.value !== (expected_value - 3)) begin
      $display("ERROR: El valor de 'value' no es el esperado después del tercer decremento.");
      $stop;
    end
    
    // Aplicar reset nuevamente
    reset = 0;      // Reset (presionar)
    #10;
    reset = 1;      // Liberar reset (debería restaurar 'value' al valor inicial)
    #10;
    
    // Verificar que el valor se haya restaurado al valor inicial
    if (dut.value !== expected_value) begin
      $display("ERROR: El valor de 'value' no se restauró correctamente después del reset.");
      $stop;
    end else begin
      $display("Valor restaurado correctamente después del reset: %d", dut.value);
    end
    
    // Esperar y finalizar la simulación
    #50;
    $display("Test completado con éxito.");
  end

  // Conectar 'value' interno al testbench para monitorizarlo
  assign value_internal = dut.value; // 'value' es interno en Top_Sub, pero lo conectamos aquí

  // Monitorizar el valor de 'value'
  initial begin
    $monitor("Time: %0t | value: %d | a: %d | reset: %b | dec_btn: %b | seg0: %d | seg1: %d", 
             $time, value_internal, a, reset, dec_btn, seg0, seg1);
  end

endmodule
