module tb_Top_Calc();

    logic clk, rst, sig, equ;
    logic [3:0] a, b;
    logic [3:0] y_out;
    logic [4:0] flag;  // ✅ Flags del DUT
    logic [7:0] seg1, seg0, seg4, seg2, seg3;

    // Instancia del DUT (Device Under Test)
    Top_Calc dut (
        .a(a),
        .b(b),
        .sig(sig),
        .equ(equ),
        .seg1(seg1),
        .seg0(seg0),
        .seg2(seg2),
        .seg3(seg3),
        .seg4(seg4),
        .flag(flag),
        .y_out(y_out)
    );

    // Generación del clock
    always #5 clk = ~clk;

    // Proceso de prueba
    initial begin
        // Inicialización
        clk = 0;
        rst = 1;
        sig = 0;
        equ = 0;
        a = 4'd4;  // ✅ Cambiado a 4
        b = 4'd2;  // ✅ Cambiado a 2
        #10 rst = 0; // Liberar reset

        // Test: SUMA (4 + 2 = 6)
        $display("Tiempo %0t: SUMA (4 + 2)", $time);
        #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == 4'd6);
        assert (flag == 5'b00000); // ✅ Sin carry ni overflow

        // RESTA (4 - 2 = 2)
        $display("Tiempo %0t: RESTA (4 - 2)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == 4'd2);
        assert (flag == 5'b00000); // ✅ Sin carry ni negativo

        // MULTIPLICACIÓN (4 * 2 = 8)
        $display("Tiempo %0t: MULTIPLICACIÓN (4 * 2)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == 4'd8);
        assert (flag == 5'b00000); // ✅ Sin desbordamiento

        // DIVISIÓN (4 / 2 = 2)
        $display("Tiempo %0t: DIVISIÓN (4 / 2)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == 4'd2);
        assert (flag == 5'b00000); // ✅ División válida

        // MÓDULO (4 % 2 = 0)
        $display("Tiempo %0t: MÓDULO (4 %% 2)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == 4'd0);
        assert (flag == 5'b00100); // ✅ Flag de cero activada

        // AND (4 & 2 = 0)
        $display("Tiempo %0t: AND (4 & 2)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == (a & b));
        assert (flag == 5'b00100); // ✅ Flag de cero activada

        // OR (4 | 2 = 6)
        $display("Tiempo %0t: OR (4 | 2)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == (a | b));
        assert (flag == 5'b00000); // ✅ Ninguna flag activada

        // XOR (4 ^ 2 = 6)
        $display("Tiempo %0t: XOR (4 ^ 2)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == (a ^ b));
        assert (flag == 5'b00000); // ✅ Ninguna flag activada

        // Shift Izquierda (4 << 2 = 0)
        $display("Tiempo %0t: Shift Izquierda (4 << 1)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == (a << 4'd2));
        assert (flag == 5'b00000); // ✅ Sin carry ni overflow

        // Shift Derecha (4 >> 2 = 1)
        $display("Tiempo %0t: Shift Derecha (4 >> 1)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == (a >> 4'd2));
        assert (flag == 5'b00000); // ✅ Ninguna flag activada
		  
		  
		  a = 4'd8;  // ✅ Cambiado a 8
        b = 4'd7;  // ✅ Cambiado a 7
		  
		  $display("Tiempo %0t: SUMA (8 + 7)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == 4'd15);
        assert (flag == 5'b00000); // ✅ Sin carry ni negativo
		  
		  
		    // RESTA (8 - 7 = 1)
        $display("Tiempo %0t: RESTA (8 - 7)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == 4'd1);
        assert (flag == 5'b00000); // ✅ Sin carry ni negativo

        // MULTIPLICACIÓN (8 * 7 = 56)
        $display("Tiempo %0t: MULTIPLICACIÓN (8 * 7)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == 4'd56);
        assert (flag == 5'b00001); // ✅ Sin desbordamiento

        // DIVISIÓN (8 / 7 = 1)
        $display("Tiempo %0t: DIVISIÓN (8 / 7)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == 4'd1);
        assert (flag == 5'b00000); // ✅ División válida

        // MÓDULO (8 % 7 = 1)
        $display("Tiempo %0t: MÓDULO (8 %% 7)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == 4'd1);
        assert (flag == 5'b00000); // ✅ Ninguna flag activada

        // AND (8 & 7 = 0b1000 & 0b0111 = 0)
        $display("Tiempo %0t: AND (8 & 7)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == (8 & 7));
        assert (flag == 5'b00100); // ✅ Flag de cero activada

        // OR (8 | 7 = 0b1000 | 0b0111 = 15)
        $display("Tiempo %0t: OR (8 | 7)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == (8 | 7));
        assert (flag == 5'b00000); // ✅ Ninguna flag activada

        // XOR (8 ^ 7 = 0b1000 ^ 0b0111 = 15)
        $display("Tiempo %0t: XOR (8 ^ 7)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == (8 ^ 7));
        assert (flag == 5'b00000); // ✅ Ninguna flag activada

        // Shift Izquierda (8 << 1 = 16)
        $display("Tiempo %0t: Shift Izquierda (8 << 1)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == (4'd8 << 4'd7));


        // Shift Derecha (8 >> 1 = 4)
        $display("Tiempo %0t: Shift Derecha (8 >> 1)", $time);
        #10 sig = 1; #10 sig = 0; #10 equ = 1; #10 equ = 0;
        $display("Resultado: y_out = %d, seg4 = %b, flag = %b", y_out, seg4, flag);
        assert (y_out == (4'd8 >> 4'd7));

		  

        // Finaliza la simulación
        #50 $finish;
    end

endmodule
