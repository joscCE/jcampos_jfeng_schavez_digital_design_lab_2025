module display_menu (
    input  logic [9:0] Q_X, Q_Y,        // Coordenadas (hasta 1023)
    output logic [7:0] R, G, B
);

    logic [18:0] addr;
    logic [23:0] color;

    // Calcular dirección (Y * ancho + X)
    always_comb begin
        if (Q_X < 640 && Q_Y < 480)
            addr = Q_Y * 640 + Q_X;
        else
            addr = 0;  // Color por defecto (negro o el primero en la ROM)
    end

    // Instancia de la ROM
    menu_ROM rom(
        .addrs(addr),
        .color(color)
    );

    // Separar el color en R, G, B
    assign R = color[23:16];
    assign G = color[15:8];
    assign B = color[7:0];

endmodule
