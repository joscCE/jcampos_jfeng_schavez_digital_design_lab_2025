module alu_timing_test #(parameter N = 2) (
    input logic clk,          // Reloj del sistema
    input logic rst,          // Reset asincrónico
    input logic [N-1:0] A,    // Operando A
    input logic [N-1:0] B,    // Operando B
    input logic [3:0] op,     // Código de operación
    output logic [N-1:0] result_out,  // Resultado final
    output logic [4:0] flags_out      // Bandera de estado [E, N, Z, C, V]
);

// Registros de entrada y salida
logic [N-1:0] reg_A, reg_B;  // Registros de entrada
logic [3:0] reg_op;          // Registro para operación
logic [N-1:0] alu_result;    // Salida de la ALU
logic [4:0] alu_flags;       // Banderas de estado

// Instancia de la ALU
ALU #(N) alu_inst (
    .a(reg_A),
    .b(reg_B),
    .op(reg_op),
    .y(alu_result),
    .f(alu_flags)
);

// Registro de entrada (Primer flip-flop)
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        reg_A <= 0;
        reg_B <= 0;
        reg_op <= 0;
    end else begin
        reg_A <= A;
        reg_B <= B;
        reg_op <= op;
    end
end

// Registro de salida (Segundo flip-flop)
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        result_out <= 0;
        flags_out <= 0;
    end else begin
        result_out <= alu_result;
        flags_out <= alu_flags;
    end
end

endmodule