`timescale 1ns/1ns

module tb_debounce;

	parameter CLK_PERIOD_NS = 40;       
	parameter DEBOUNCE_TIME_NS = 10500000;
	parameter DIV_CNT = 17;

	reg clk = 0;
	reg btn = 0;
	wire out;

	debounce #(.DIV_CNT(DIV_CNT)) uut (
		.clk(clk),
		.btn(btn),
		.out(out)
	);

	// Reloj de 25 MHz
	always #(CLK_PERIOD_NS / 2) clk = ~clk;

	initial begin
		$display("== Inicio de simulacion ==");

		// Inicializacion
		#1000;
		assert(out == 0) else $fatal("Error: out != 0 al inicio");

		// Prueba 1: Rebotes y mantener presionado
		$display("Prueba 1: rebotes y mantener presionado");
		#500 btn = 1;
		#100 btn = 0;
		#80  btn = 1;
		#100 btn = 0;
		#50  btn = 1;
		#100000 btn = 1;

		wait(out == 1);
		$display("Prueba 1: out = 1 tras rebotes");

		btn = 0;
		#(DEBOUNCE_TIME_NS + 1000);
		assert(out == 0) else $fatal("Prueba 1: out no volvio a 0");
		$display("Prueba 1: out = 0 tras soltar");

		// Prueba 2: Pulso limpio y largo
		$display("Prueba 2: pulso limpio y largo");
		btn = 1;
		#(DEBOUNCE_TIME_NS + 1000);

		assert(out == 1) else $fatal("Prueba 2: out no se activo");
		$display("Prueba 2: out = 1 tras pulso largo");

		btn = 0;
		#(DEBOUNCE_TIME_NS + 1000);
		assert(out == 0) else $fatal("Prueba 2: out no se desactivo");
		$display("Prueba 2: out = 0 tras soltar");

		// Prueba 3: Pulso muy corto
		$display("Prueba 3: pulso corto");
		btn = 1;
		#100000;  // 0.1 ms
		btn = 0;

		#(DEBOUNCE_TIME_NS);
		assert(out == 0) else $fatal("Prueba 3: out no debio activarse");
		$display("Prueba 3: pulso corto ignorado correctamente");

		// Prueba 4: Dos pulsos validos separados
		$display("Prueba 4: dos pulsos validos separados");
		btn = 1;
		#(DEBOUNCE_TIME_NS + 1000);
		wait(out == 1);
		btn = 0;
		#(DEBOUNCE_TIME_NS + 1000);
		assert(out == 0);

		btn = 1;
		#(DEBOUNCE_TIME_NS + 1000);
		wait(out == 1);
		btn = 0;
		#(DEBOUNCE_TIME_NS + 1000);
		assert(out == 0);
		$display("Prueba 4: dos pulsos reconocidos correctamente");

		$display("== Fin de simulacion exitosa ==");
		$finish;
	end

endmodule
