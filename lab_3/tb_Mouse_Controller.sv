`timescale 1ns/1ps

module tb_Mouse_Controller;

    // Entradas
    logic PS2_CLK;
    logic PS2_DAT;

    // Salidas
    logic [9:0] Mouse_CoordsX;
    logic [9:0] Mouse_CoordsY;
    logic [2:0] debug_state;

    // Instancia del DUT (Device Under Test)
    Mouse_Controller dut (
        .PS2_CLK(PS2_CLK),
        .PS2_DAT(PS2_DAT),
        .Mouse_CoordsX(Mouse_CoordsX),
        .Mouse_CoordsY(Mouse_CoordsY),
        .debug_state(debug_state)
    );

    // Clock generation: PS2_CLK (vamos a simularlo lento)
    initial begin
        PS2_CLK = 1;
        forever #50 PS2_CLK = ~PS2_CLK; // 100ns de periodo (10 MHz aprox)
    end

    // Variables para el estímulo
    logic [23:0] packet;  // 3 bytes = 24 bits
    int i;

    // Task para enviar un paquete PS/2
    task send_packet(input [23:0] pckt);
        begin
            for (i = 0; i < 24; i = i + 1) begin
                @(negedge PS2_CLK);
                PS2_DAT = pckt[i];
            end
        end
    endtask

    // Test principal
    initial begin
        // Inicialización
        PS2_DAT = 1; // Idle de PS/2 es línea alta
        #1000;

        // Primer paquete: movimiento pequeño hacia la derecha y abajo
        // Formato típico:
        // Byte 1 (estado): 8'b00001000 -> solo bit 3 (signo X) = 0, (signo Y) = 0
        // Byte 2 (delta X): 8'b00000101 -> +5
        // Byte 3 (delta Y): 8'b00000101 -> +5
        packet = {8'b00000101, 8'b00000101, 8'b00001000};
        send_packet(packet);

        #5000;

        // Segundo paquete: movimiento hacia la izquierda y arriba (negativo)
        // Byte 1: 8'b00001100 -> bit 3 (signo X) = 1, bit 2 (signo Y) = 1
        // Byte 2: 8'b11111011 -> -5 (complemento a dos)
        // Byte 3: 8'b11111011 -> -5
        packet = {8'b11111011, 8'b11111011, 8'b00001100};
        send_packet(packet);

        #5000;

        // Otro paquete: sin movimiento
        packet = {8'b00000000, 8'b00000000, 8'b00001000};
        send_packet(packet);

        #5000;

        // Finalizar simulación
        $stop;
    end

endmodule
