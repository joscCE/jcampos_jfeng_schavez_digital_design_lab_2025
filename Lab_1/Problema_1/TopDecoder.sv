module TopDecoder(
    input logic [3:0] a,
    output logic [3:0] y1, y0
);

    // Instanciamos el módulo decoderBDC
    decoderBDC uut (
        .a(a), 
        .y1(y1), 
        .y0(y0)
    );

endmodule
