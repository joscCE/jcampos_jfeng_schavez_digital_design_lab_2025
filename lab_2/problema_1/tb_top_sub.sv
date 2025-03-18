`timescale 1ns / 1ps

module tb_top_sub;
	
	parameter x = 4;
	
	//Señales DUT
	
	logic [x-1:0] a, b, r;
	logic cin, cout;
	
	// Instanciar módulo
	
	top_sub #(.x(x)) dut (
	 .a(a),
	 .b(b),
	 .cin(cin),
	 .r(r),
	 .cout(cout)
	);
	
	initial begin
		$display("Iniciando pruebas...");
		
		// Prueba 1: 5 - 3
		
		a = 4'b0101; // 5
		b = 4'b0011; // 3
		cin = 0;
		#10;
		check_result(4'b0010); // 5 - 3 = 2
		
		
		// Prueba 2: 8 - 8
		a = 4'b1000; // 8
		b = 4'b1000; // 8
		cin = 0;
		#10;
		check_result(4'b0000); // 8 - 8 = 0
		
		
		// Prueba 3: 0 - 1 
		a = 4'b0000; // 0
		b = 4'b0001; // 1
		cin = 0;
		#10;
		check_result(4'b1111); // 0 - 1 = -1
		
		
		$display("Todas las pruebas pasaron correctamente.");
		$finish; 
	end 
	
	
	task check_result(
		input logic [x-1:0] expected_r);

		if (r !== expected_r) begin
			$display("ERROR en la prueba: a=%b, b=%b, cin=%b", a, b, cin);
			$display("Esperado -> r=%b", expected_r);
			$display("Obtenido -> r=%b", r);
			$stop;
			
		end else begin
			$display("Prueba PASADA: a=%b, b=%b, cin=%b -> r=%b", a, b, cin, r);
		end
		
	endtask


endmodule	