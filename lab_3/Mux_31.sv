module Mux_31 #(parameter N = 3)(
    input [N-1:0] A, B, C,
    input [1:0] S,
    output logic [N-1:0] D // Usa 'logic' en vez de 'wire'
);

always_comb begin
    case (S)
        2'b00: D = A;
        2'b01: D = B;
        2'b10: D = C;
        default: D = A; // valor por defecto
    endcase
end

endmodule