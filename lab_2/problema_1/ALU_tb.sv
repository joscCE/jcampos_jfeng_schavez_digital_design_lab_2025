

module ALU_tb;
    logic [3:0] a, b, op;
    logic [3:0] y;
    logic [4:0] f;
    
    // Instancia de la ALU
    ALU uut (
        .a(a),
        .b(b),
        .op(op),
        .y(y),
        .f(f)
    );
    
    initial begin
        // Pruebas de operaciones básicas
        a = 4'b1011; b = 4'b0011;
        
        // Suma
        op = 4'b0000; #10;
        $display("SUMA: a=%b, b=%b, y=%b, f=%b", a, b, y, f);
        
        // Resta
        op = 4'b0001; #10;
        $display("RESTA: a=%b, b=%b, y=%b, f=%b", a, b, y, f);
        
        // Multiplicación
        op = 4'b0010; #10;
        $display("MULTIPLICACION: a=%b, b=%b, y=%b, f=%b", a, b, y, f);
        
        // División
        op = 4'b0011; #10;
        $display("DIVISION: a=%b, b=%b, y=%b, f=%b", a, b, y, f);
        
        // Módulo
        op = 4'b0100; #10;
        $display("MODULO: a=%b, b=%b, y=%b, f=%b", a, b, y, f);
        
        // AND
        op = 4'b0101; #10;
        $display("AND: a=%b, b=%b, y=%b", a, b, y);
        
        // OR
        op = 4'b0110; #10;
        $display("OR: a=%b, b=%b, y=%b", a, b, y);
        
        // XOR
        op = 4'b0111; #10;
        $display("XOR: a=%b, b=%b, y=%b", a, b, y);
        
        // Shift Left
        op = 4'b1000; #10;
        $display("SHIFT LEFT: a=%b, y=%b", a, y);
        
        // Shift Right
        op = 4'b1001; #10;
        $display("SHIFT RIGHT: a=%b, y=%b", a, y);
        

    end
endmodule
