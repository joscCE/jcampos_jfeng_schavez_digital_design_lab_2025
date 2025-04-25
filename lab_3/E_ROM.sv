module E_ROM (
    input  logic [12:0] addr,
    output logic [23:0] color
);

    logic [23:0] memory [0:4899];

    initial begin
        $readmemh("E.mem", memory);
    end

    assign color = memory[addr];

endmodule
