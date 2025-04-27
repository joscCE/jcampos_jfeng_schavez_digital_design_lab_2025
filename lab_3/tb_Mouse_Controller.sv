module tb_Mouse_Controller;

    reg PS2_CLK;
    reg PS2_DAT;
    reg rst;

    wire [15:0] Mouse_CoordsX;
    wire [15:0] Mouse_CoordsY;
    wire [2:0] debug_state;
    wire [3:0] debug_bit_counter;
    wire [1:0] debug_byte_counter;
    wire [7:0] debug_status, debug_dx, debug_dy;

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

    // Simular PS2_CLK (baja y sube cada 5ns)
    always begin
        PS2_CLK = 0;
        #5 PS2_CLK = 1;
        #5;
    end

    // Tarea para mandar un byte al mouse con protocolo PS/2
    task send_ps2_byte(input [7:0] data);
        integer i;
        reg parity;
        begin
            parity = 1'b1;  // Odd parity inicial (se invierte en el proceso)

            // Start bit
            @(negedge PS2_CLK);
            PS2_DAT = 0;

            // Data bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                @(negedge PS2_CLK);
                PS2_DAT = data[i];
                parity = parity ^ data[i];  // actualizar paridad
            end

            // Parity bit
            @(negedge PS2_CLK);
            PS2_DAT = parity;

            // Stop bit
            @(negedge PS2_CLK);
            PS2_DAT = 1;

            // Idle state
            @(negedge PS2_CLK);
            PS2_DAT = 1;
        end
    endtask

    initial begin
        // Inicialización
        PS2_DAT = 1;
        rst = 0;
        #10 rst = 1;
        #20 rst = 0;

        // Esperar un poquito
        #50;

        // Mandar un paquete típico de mouse
        // Normalmente el mouse manda 3 bytes: Status, DX, DY
        // Puedes inventar datos como:
        // status = 8'b0000_1000 (solo bit de Y sign=1)
        // dx = 8'b0000_0011 (mover 3 en x)
        // dy = 8'b1111_1110 (mover -2 en y)

        send_ps2_byte(8'b0000_1000); // Status byte
        send_ps2_byte(8'b0000_0011); // DX byte
        send_ps2_byte(8'b1111_1110); // DY byte

        // Esperar un poco y terminar
        #1000 $finish;
    end

    initial begin
        $monitor("At time %t ns: X=%d, Y=%d, Status=%b, DX=%d, DY=%d, State=%b, BitCounter=%d, ByteCounter=%d",
                 $time, Mouse_CoordsX, Mouse_CoordsY, debug_status, debug_dx, debug_dy,
                 debug_state, debug_bit_counter, debug_byte_counter);
    end

endmodule
