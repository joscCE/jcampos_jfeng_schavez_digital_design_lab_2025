module display_menu(
    input  logic clk,                        // Señal de reloj
    input  logic [9:0] Q_X, Q_Y,             // Coordenadas del píxel actual
    output logic [7:0] R, G, B               // Salida de color
);

    // Dimensiones de la imagen
    localparam int TILE_W = 200;
    localparam int TILE_H = 200;

    localparam int OFFSET_X = 225;
    localparam int OFFSET_Y = 250;

    logic inside_image;
    logic [9:0] local_x, local_y;
    logic [15:0] addr;
    logic [23:0] color;

    // ==== Señal de parpadeo ====
    logic [28:0] blink_counter = 0; 
    logic blink_on = 1;

    always_ff @(posedge clk) begin
        blink_counter <= blink_counter + 1;
        if (blink_counter == 24'd80_000_000) begin 
            blink_counter <= 0;
            blink_on <= ~blink_on;
        end
    end

    // Verificamos si el píxel actual está dentro del área de la imagen
    assign inside_image = (Q_X >= OFFSET_X) && (Q_X < OFFSET_X + TILE_W) &&
                          (Q_Y >= OFFSET_Y) && (Q_Y < OFFSET_Y + TILE_H);

    assign local_x = Q_X - OFFSET_X;
    assign local_y = Q_Y - OFFSET_Y;

    // Dirección de memoria
    always_ff @(posedge clk) begin
        if (inside_image)
            addr <= local_y * TILE_W + local_x;
        else
            addr <= 0;
    end

    // Instancia de la ROM
    Start_B_ROM rom (
        .addr(addr),
        .color(color)
    );

    // Salida RGB con parpadeo
    always_comb begin
        if (inside_image && blink_on) begin
            if (color == 24'b0) begin
                R = 8'd255;
                G = 8'd255;
                B = 8'd255;
            end else begin
                B = color[23:16];
                G = color[15:8];
                R = color[7:0];
            end
        end else begin
            R = 8'd255;
            G = 8'd255;
            B = 8'd255;
        end
    end
endmodule
