module deco_sub3(
    input logic [5:0] a, // Cambiado a 6 bits
    output logic [7:0] seg1, seg0
);

    // Variables medias
    logic [3:0] y1, y0;
    
    // Separar el número de 6 bits en dos BCD
    always_comb begin
        y1 = a / 10; // Dígito de decenas
        y0 = a % 10; // Dígito de unidades
    end

    // Instanciamos el módulo Decoder7seg con la lógica inversa
    always_comb begin
        case (y0)
            4'd0: seg0 = 8'b11000000;
            4'd1: seg0 = 8'b11111001;
            4'd2: seg0 = 8'b10100100;
            4'd3: seg0 = 8'b10110000;
            4'd4: seg0 = 8'b10011001;
            4'd5: seg0 = 8'b10010010;
            4'd6: seg0 = 8'b10000010;
            4'd7: seg0 = 8'b11111000;
            4'd8: seg0 = 8'b10000000;
            4'd9: seg0 = 8'b10010000;
            default: seg0 = 8'b11111111;
        endcase

        case (y1)
            4'd0: seg1 = 8'b11000000;
            4'd1: seg1 = 8'b11111001;
            4'd2: seg1 = 8'b10100100;
            4'd3: seg1 = 8'b10110000;
            4'd4: seg1 = 8'b10011001;
            4'd5: seg1 = 8'b10010010;
            4'd6: seg1 = 8'b10000010;
            4'd7: seg1 = 8'b11111000;
            4'd8: seg1 = 8'b10000000;
            4'd9: seg1 = 8'b10010000;
            default: seg1 = 8'b11111111;
        endcase
    end

endmodule