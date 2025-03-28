module Top_Calc(
    input logic [3:0] a, b,  // Entradas de la calculadora
    input logic sig, equ,    // Botones para cambiar operación y calcular
    output logic [7:0] seg1, seg0, seg2, seg3, seg4,  // Displays de 7 segmentos
    output logic [4:0] flag,
    output logic [3:0] y_out // Salida del resultado de la ALU
);

    logic [3:0] op = 4'b0000;  // Código de operación (inicializado correctamente)
    logic [3:0] y;    // Resultado de la ALU
    logic [4:0] f;    // Flags de la ALU
    logic [3:0] result = 4'b0000; // Variable para almacenar el resultado de la ALU (evitar X/Z)

    // Salidas temporales de cada decoder
    logic [7:0] seg1_dec, seg0_dec;
    logic [7:0] seg3_bin, seg2_bin, seg1_bin, seg0_bin;

    // Instancia de la ALU
    ALU alu_inst (
        .a(a),
        .b(b),
        .op(op),
        .y(y),
        .f(f)
    );

    // Control del código de operación con el botón 'sig'
    always_ff @(posedge sig) begin
    if (op == 4'b1001) 
        op <= 4'b0000;  // Reinicio inmediato al primer estado
    else 
        op <= op + 1'b1; // Avanzar al siguiente modo
	 end
    
    // Lógica para mostrar el código de operación en SEG4
    always_comb begin
        case (op)
            4'b0000: seg4 = 8'b01001001; // "+"
            4'b0001: seg4 = 8'b11111101; // "-"
            4'b0010: seg4 = 8'b10010001; // "*"
            4'b0011: seg4 = 8'b10000101; // "/"
            4'b0100: seg4 = 8'b10110101; // "%"
            4'b0101: seg4 = 8'b00010011; // AND
            4'b0110: seg4 = 8'b10000011; // OR
            4'b0111: seg4 = 8'b10101001; // XOR
            4'b1000: seg4 = 8'b01100011; // "<<"
            4'b1001: seg4 = 8'b00001111; // ">>"
            default: seg4 = 8'b11111111; // Apagado
        endcase
    end
    
    // Captura del resultado al presionar "equ"
		 always_ff @(posedge equ) begin
		 result <= y;  // Guardar el resultado de la ALU
		 flag <= f;    // Guardar los flags para que no cambien antes de equ
		end

    // Asignar el resultado de la ALU a la salida directa
    assign y_out = y;

    // Instancia del decoder normal
    Decoder dec_inst (
        .a(result),    
        .seg1(seg1_dec),  
        .seg0(seg0_dec),
		  .equ(equ),
        .err(f[4])
    );

    // Instancia del decoder binario
    Decoder_bin dec_bin_inst (
        .a(result),    
        .seg3(seg3_bin), 
        .seg2(seg2_bin), 
        .seg1(seg1_bin), 
        .seg0(seg0_bin)
    );

    // Selección del decoder según el código de operación
	always_comb begin
    if (op >= 4'b0101 && op <= 4'b1001) begin
        // Usar Decoder_bin
        seg3 = seg3_bin;
        seg2 = seg2_bin;
        seg1 = seg1_bin;
        seg0 = seg0_bin;
    end else begin
        // Usar Decoder normal
        seg3 = 8'b11111111; // Apagado o sin usar
        if (equ) begin
            seg2 = {6'b111111, ~flag[3], 1'b1}; // Usar flag[3] capturado en equ
        end else begin
            seg2 = 8'b11111111; // Mantener apagado hasta que se presione equ
        end
        seg1 = seg1_dec;
        seg0 = seg0_dec;
    end
end

endmodule
