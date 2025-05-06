module display_menu(
    input  logic clk,
	 input turn,
    input  logic [9:0] Q_X, Q_Y,
    output logic [7:0] R, G, B
	 
);

    // Dimensiones
    localparam int START_W = 200, START_H = 200;
    localparam int PLAYER_W = 250, PLAYER_H = 190;

    // Posiciones centradas (ajústalas si es necesario)
    localparam int START_X = (640 - START_W) / 2;     // Centro horizontal
    localparam int START_Y = 250;

    localparam int PLAYER1_X = 50;
    localparam int PLAYER2_X = 640 - PLAYER_W - 50;
    localparam int PLAYER_Y  = 50; // Ambos players están arriba
	 
	 //dimesiones cuadro blaco del jugador no seleccionado
	 
	   // Coordenadas del cuadro blanco sobre la bolita
    localparam int BOX_W = 120;
    localparam int BOX_H = 70;

    // Posición relativa del cuadro sobre cada imagen (ajustar si es necesario)
    localparam int P1_BOX_X = 100; // dentro de 250x190
    localparam int P1_BOX_Y = 8;

    localparam int P2_BOX_X = 105;
    localparam int P2_BOX_Y = 10;

    // Área del cuadro blanco para el jugador NO seleccionado
    logic in_box_p1, in_box_p2;

    assign in_box_p1 = (turn == 1) &&  // Player 1 NO seleccionado
                       (p1_x >= P1_BOX_X) && (p1_x < P1_BOX_X + BOX_W) &&
                       (p1_y >= P1_BOX_Y) && (p1_y < P1_BOX_Y + BOX_H);

    assign in_box_p2 = (turn == 0) &&  // Player 2 NO seleccionado
                       (p2_x >= P2_BOX_X) && (p2_x < P2_BOX_X + BOX_W) &&
                       (p2_y >= P2_BOX_Y) && (p2_y < P2_BOX_Y + BOX_H);
	 
	 
	 
	 
	 

    // Señales comunes
    logic inside_start, inside_p1, inside_p2;
    logic [9:0] local_x, local_y;
    logic [9:0] p1_x, p1_y, p2_x, p2_y;

    logic [15:0] addr_start, addr_p1, addr_p2;
    logic [23:0] color_start, color_p1, color_p2;

    // === Blink ===
    logic [26:0] blink_counter = 0;
    logic blink_on = 1;

    always_ff @(posedge clk) begin
        blink_counter <= blink_counter + 1;
        if (blink_counter == 27'd80_000_000) begin
            blink_counter <= 0;
            blink_on <= ~blink_on;
        end
    end

    // Área de cada imagen
    assign inside_start = (Q_X >= START_X)  && (Q_X < START_X + START_W) &&
                          (Q_Y >= START_Y)  && (Q_Y < START_Y + START_H);

    assign inside_p1 = (Q_X >= PLAYER1_X) && (Q_X < PLAYER1_X + PLAYER_W) &&
                       (Q_Y >= PLAYER_Y)  && (Q_Y < PLAYER_Y + PLAYER_H);

    assign inside_p2 = (Q_X >= PLAYER2_X) && (Q_X < PLAYER2_X + PLAYER_W) &&
                       (Q_Y >= PLAYER_Y)  && (Q_Y < PLAYER_Y + PLAYER_H);

    // Coordenadas locales
    assign local_x = Q_X - START_X;
    assign local_y = Q_Y - START_Y;

    assign p1_x = Q_X - PLAYER1_X;
    assign p1_y = Q_Y - PLAYER_Y;

    assign p2_x = Q_X - PLAYER2_X;
    assign p2_y = Q_Y - PLAYER_Y;

    // Cálculo de dirección
    always_ff @(posedge clk) begin
        if (inside_start)
            addr_start <= local_y * START_W + local_x;
        else
            addr_start <= 0;

        if (inside_p1)
            addr_p1 <= p1_y * PLAYER_W + p1_x;
        else
            addr_p1 <= 0;

        if (inside_p2)
            addr_p2 <= p2_y * PLAYER_W + p2_x;
        else
            addr_p2 <= 0;
    end

    // Instancias de ROM
    Start_B_ROM rom_start (
        .addr(addr_start),
        .color(color_start)
    );

    Player1_ROM rom_p1 (
        .addr(addr_p1),
        .color(color_p1)
    );

    Player2_ROM rom_p2 (
        .addr(addr_p2),
        .color(color_p2)
    );

    // Mux de color según prioridad: Player2 > Start > Player1
     always_comb begin
        // Fondo blanco por defecto
        R = 8'd255;
        G = 8'd255;
        B = 8'd255;

        // Prioridad: cuadro blanco > imágenes
        if (in_box_p1 || in_box_p2) begin
			R = 8'd255;
			G = 8'd255;
			B = 8'd255;
        end else if (inside_p2) begin
            {B, G, R} = (color_p2 == 24'd0) ? 24'hFFFFFF : color_p2;
        end else if (inside_start && blink_on) begin
            {B, G, R} = (color_start == 24'd0) ? 24'hFFFFFF : color_start;
        end else if (inside_p1) begin
            {B, G, R} = (color_p1 == 24'd0) ? 24'hFFFFFF : color_p1;
        end
    end
endmodule
