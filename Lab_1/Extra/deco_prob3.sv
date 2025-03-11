module deco_prob3 (
    input  logic [3:0] a,   // Entrada de 4 bits
    input  logic       o,   // Entrada de 1 bit
    output logic [7:0] seg0, seg1 // Dos displays de 7 segmentos
);

    // Función para decodificar el segundo display
    function automatic logic [7:0] HexTo7seg1(input logic O);
        case (O)
            1'b1: HexTo7seg1 = 8'b00000011;
            default: HexTo7seg1 = 8'b11111111;
        endcase
    endfunction

    // Función para decodificar el primer display
    function automatic logic [7:0] HexTo7Seg0(input logic [3:0] a0, input logic O);
        if (O == 1'b1) begin
            return 8'b01110001; // Si O es '1', mostrar F en HEX
        end else begin
            case (a0)
                4'b0000: return 8'b00000010; // 0
                4'b0001: return 8'b10011111; // 1
                4'b0010: return 8'b00100101; // 2
                4'b0011: return 8'b00001101; // 3
                4'b0100: return 8'b10011001; // 4
                4'b0101: return 8'b01001001; // 5
                4'b0110: return 8'b01000001; // 6
                4'b0111: return 8'b00011111; // 7
                4'b1000: return 8'b00000001; // 8
                4'b1001: return 8'b00001001; // 9
                4'b1010: return 8'b00010001; // A
                4'b1011: return 8'b11000001; // B
                4'b1100: return 8'b01100011; // C
                4'b1101: return 8'b10000101; // D
                4'b1110: return 8'b01100001; // E
                4'b1111: return 8'b01110001; // F
                default: return 8'b11111111; // Apagado
            endcase;
        end
    endfunction

    // Asignación de los valores de salida
    assign seg0 = HexTo7Seg0(a, o);
    assign seg1 = HexTo7seg1(o);

endmodule