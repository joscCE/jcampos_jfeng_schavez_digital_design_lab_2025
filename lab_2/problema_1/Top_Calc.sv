module Top_Calc;

    logic [3:0] a, b, op;
    logic [3:0] y;
    logic [4:0] f;

    // Instancia de la ALU
    ALU alu_inst (
        .a(a),
        .b(b),
        .op(op),
        .y(y),
        .f(f)
    );

endmodule