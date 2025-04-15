module Piece_ROM (
    input  logic [12:0] addr,         // 13 bits para 0–4899
    output logic [23:0] color         // RRGGBB
);

    logic [23:0] memory [0:4899];     // 70 x 70 = 4900

    initial begin
        $readmemh("piece.mem", memory); // Asegúrate de tener piece.mem en el proyecto
    end

    assign color = memory[addr];

endmodule
