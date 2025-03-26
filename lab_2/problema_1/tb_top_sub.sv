`timescale 1ns / 1ps

module tb_top_sub;
	
	parameter N = 4;
	
	//Señales DUT
	
	logic [N-1:0] a, b, r;
	logic cin, cout, Ne;
	
	// Instanciar módulo
	
	top_sub #(.N(N)) dut (
	 .a(a),
	 .b(b),
	 .cin(cin),
	 .r(r),
	 .cout(cout),
	 .Ne(Ne)
	);
	
	initial begin
		$display("Iniciando pruebas...");
		
		// Prueba 1: 5 - 3
		
		a = 4'b0101; // 5
		b = 4'b0011; // 3
		cin = 0;
		#10;
		check_result(4'b0010, 0); // 5 - 3 = 2, Ne = 0
		
		
		// Prueba 2: 8 - 8 
		a = 4'b1000; // 8
		b = 4'b1000; // 8
		cin = 0;
		#10;
		check_result(4'b0000, 0); // 8 - 8 = 0, Ne = 0
		
		
		// Prueba 3: 0 - 1 
		a = 4'b0000; // 0
		b = 4'b0001; // 1
		cin = 0;
		#10;
		check_result(4'b0001, 1); // |0 - 1| = 1, Ne = 1
		
		// Prueba 4: 2 - 3 
		a = 4'b0010; // 2
		b = 4'b0011; // 3
		cin = 0;
		#10;
		check_result(4'b0001, 1); // |2 - 3| = 1, Ne = 1
		
		
		// Prueba 4: 3 - 4 
		a = 4'b0011; // 2
		b = 4'b0100; // 3
		cin = 0;
		#10;
		check_result(4'b0001, 1); // |3 - 4| = 1, Ne = 1
		
		
		$display("Todas las pruebas pasaron correctamente.");
		$finish; 
	end 
	
	
	task check_result(
		input logic [N-1:0] expected_r,
		input logic expected_Ne
	);
		if (r !== expected_r || Ne !== expected_Ne) begin
			$display("ERROR en la prueba: a=%b, b=%b, cin=%b", a, b, cin);
			$display("Esperado -> r=%b, Ne=%b", expected_r, expected_Ne);
			$display("Obtenido -> r=%b, Ne=%b", r, Ne);
			$stop;
		end else begin
			$display("Prueba PASADA: a=%b, b=%b, cin=%b -> r=%b, Ne=%b", a, b, cin, r, Ne);
		end
	endtask


endmodule	