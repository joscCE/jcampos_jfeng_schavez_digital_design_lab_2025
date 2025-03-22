module Top_Calc();

    // Señales para conectar con el módulo Multiplier
    logic [3:0] a, b;
    logic [7:0] p;

    // Instancia del módulo Multiplier
    Multiplier uut (
        .a(a),
        .b(b),
        .p(p)
    );



endmodule