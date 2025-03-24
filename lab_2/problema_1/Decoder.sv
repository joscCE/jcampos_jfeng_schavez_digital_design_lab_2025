module Decoder(
    input logic [3:0] a,         // Entrada de 4 bits
    output logic [7:0] seg1, seg0 // Salidas a displays de 7 segmentos
);

    logic [3:0] y1, y0;

    // Convertir a BCD (4 bits solo permite valores de 0 a 15)
    always_comb begin
        y1 = (a >= 10) ? 4'd1 : 4'd0; // Dígito de decenas (solo 0 o 1)
        y0 = a % 10;                   // Dígito de unidades
    end

    // Decodificación de los 7 segmentos (bits reordenados)
    always_comb begin
        case (y0)
            4'd0: seg0 = 8'b00000011;
            4'd1: seg0 = 8'b10011111;
            4'd2: seg0 = 8'b00100101;
            4'd3: seg0 = 8'b00001101;
            4'd4: seg0 = 8'b10011001;
            4'd5: seg0 = 8'b01001001;
            4'd6: seg0 = 8'b01000001;
            4'd7: seg0 = 8'b00011111;
            4'd8: seg0 = 8'b00000001;
            4'd9: seg0 = 8'b00001001;
            default: seg0 = 8'b11111111; // Apagado
        endcase

        case (y1)
            4'd0: seg1 = 8'b00000011; // 0
            4'd1: seg1 = 8'b10011111; // 1
            default: seg1 = 8'b11111111; // Apagado (nunca debería activarse)
        endcase
    end

endmodule
