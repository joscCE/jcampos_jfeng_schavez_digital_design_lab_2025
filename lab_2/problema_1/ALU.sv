module ALU #(parameter N = 4) (
    input logic [N-1:0] a, b,
    input logic [3:0] op,  // Código de operación (4 bits)
    output logic [N-1:0] y, 
    output logic [4:0] f   // f = [E, N, Z, C, V]  
);

	// E = Error, N = Negativo, Z = Cero, C = Acarreo, V = Desbordamiento

    // Variables para los flags
    logic [N-1:0] y_adder, y_sub, y_multi, y_div, y_mod;
    logic err_mod, err_div, v_multi, c_adder, c_sub, ne_sub;

    // Instancias aritméticas de módulos (ajustados a `N`)
    top_mod #(.N(N)) mod_inst(
        .a(a),
        .b(b),
        .r(y_mod),
        .err(err_mod)
    );

    top_div #(.N(N)) div_inst(
        .a(a),
        .b(b),
        .d(y_div),
        .err(err_div)
    );

    Multiplier #(.N(N)) multi_inst(
        .a(a),
        .b(b),
        .p(y_multi),
        .v(v_multi)
    );

    FullAdder #(.N(N)) adder_inst(
        .a(a),
        .b(b),
        .cin(1'b0),  
        .cout(c_adder),
        .s(y_adder)  
    );

    top_sub #(.N(N)) sub_inst(
        .a(a),
        .b(b),
        .cin(1'b0), 
        .cout(c_sub),
        .Ne(ne_sub),
        .r(y_sub)
    );

    // Lógica de la ALU
    always_comb begin
        f = 5'b00000; // Bandera en estado inicial
        case (op)
            4'b0000: begin 
                y = y_adder; 
                f[1] = c_adder; // Acarreo
					 f[0] = c_adder;
            end
            4'b0001: begin 
                y = y_sub; 
                f[1] = c_sub;   // Prestado
                f[3] = ne_sub;  // Negativo
            end
            4'b0010: begin 
                y = y_multi; 
                f[0] = v_multi; // Desbordamiento
            end
            4'b0011: begin 
                y = y_div; 
                f[4] = err_div; // Error
            end
            4'b0100: begin 
                y = y_mod; 
                f[4] = err_mod; // Error
            end
            4'b0101: y = a & b;  // AND
            4'b0110: y = a | b;  // OR
            4'b0111: y = a ^ b;  // XOR
            4'b1000: y = a << b; // Shift Left (mantiene el tamaño `N`)
            4'b1001: y = a >> b; // Shift Right (mantiene el tamaño `N`)
            default: y = {N{1'b0}}; // Valor por defecto
        endcase

        // Bandera Z (Cero)
        f[2] = (y == {N{1'b0}}) ? 1'b1 : 1'b0;
    end

endmodule
