module Top_Sub
    #(parameter N=6)
    (
    input logic [N-1:0] a,
    input logic reset,  // Reset asincrónico
    input logic dec_btn,  // Botón de decremento
    input logic clk,  // Se necesita un reloj para sincronizar la lógica
    output logic [7:0] seg1, seg0,
    output logic [N-1:0] value  // Se expone para pruebas
    );

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            value <= a;  
            $display("RESET: Valor inicializado a %0d", a);
        end else if (dec_btn) begin
            if (value == 0) begin
                value <= (2**N) - 1;  // Asignar el valor máximo directamente
                $display("UNDERFLOW: Reiniciado a %0d", (2**N) - 1);
            end else begin
                value <= value - 1'b1;
                $display("DECREMENTO: Nuevo valor %0d", value - 1'b1);
            end
        end
    end

    TopDecoder topdec(
        .a(value),
        .seg0(seg0),
        .seg1(seg1)
    );

endmodule
