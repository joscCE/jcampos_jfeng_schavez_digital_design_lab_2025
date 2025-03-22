module FullAdder #(
    parameter N = 4 // Parámetro de tamaño (por defecto 4 bits)
)(
    input  logic [N-1:0] a, b,  // Entradas de N bits
    input  logic cin,            // Carry de entrada
    output logic [N-1:0] s,      // Salida de suma
    output logic cout            // Carry de salida final
);

    
    logic [N-2:0] c; 

    
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : FA
            
            if (i == 0) begin
                fulladderbit FA_bit (
                    .a(a[i]), .b(b[i]), .cin(cin),
                    .s(s[i]), .cout(c[i])
                );
            end else if (i == N-1) begin
                
                fulladderbit FA_bit (
                    .a(a[i]), .b(b[i]), .cin(c[i-1]),
                    .s(s[i]), .cout(cout) 
                );
            end else begin
       
                fulladderbit FA_bit (
                    .a(a[i]), .b(b[i]), .cin(c[i-1]),
                    .s(s[i]), .cout(c[i])
                );
            end
        end
    endgenerate

endmodule
