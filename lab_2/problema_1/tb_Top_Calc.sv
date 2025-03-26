`timescale 1ns / 1ps

module tb_Top_Calc();

    // Inputs
    logic [3:0] a, b;
    logic sig, equ;
    
    // Outputs
    logic [7:0] seg1, seg0, seg2, seg3, seg4;
    logic [4:0] flag;
    
    // Instantiate the Unit Under Test (UUT)
    Top_Calc uut (
        .a(a),
        .b(b),
        .sig(sig),
        .equ(equ),
        .seg1(seg1),
        .seg0(seg0),
        .seg2(seg2),
        .seg3(seg3),
        .seg4(seg4),
        .flag(flag)
    );
    
    // Clock generation for button simulation
    logic clk;
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    // Test procedure
    initial begin
        // Initialize Inputs
        a = 0;
        b = 0;
        sig = 0;
        equ = 0;
        
        // Wait for global reset
        #100;
        
        // Test each operation with 2 different input pairs
        
        // 1. SUMA (+)
        $display("\nTesting SUMA (+) operation:");
        a = 4'b0011; b = 4'b0100; // 3 + 4
        press_equ();
        check_result(7, "3 + 4");
        
        a = 4'b1010; b = 4'b0110; // 10 + 6
        press_equ();
        check_result(16, "10 + 6");
        
        // 2. RESTA (-)
        press_sig();
        $display("\nTesting RESTA (-) operation:");
        a = 4'b1000; b = 4'b0011; // 8 - 3
        press_equ();
        check_result(5, "8 - 3");
        
        a = 4'b0101; b = 4'b1000; // 5 - 8 (underflow)
        press_equ();
        check_result(-3, "5 - 8");
        
        // 3. MULTIPLICACIÓN (*)
        press_sig();
        $display("\nTesting MULTIPLICACION (*) operation:");
        a = 4'b0011; b = 4'b0101; // 3 * 5
        press_equ();
        check_result(15, "3 * 5");
        
        a = 4'b0110; b = 4'b0110; // 6 * 6
        press_equ();
        check_result(36, "6 * 6");
        
        // 4. DIVISIÓN (/)
        press_sig();
        $display("\nTesting DIVISION (/) operation:");
        a = 4'b1000; b = 4'b0010; // 8 / 2
        press_equ();
        check_result(4, "8 / 2");
        
        a = 4'b1001; b = 4'b0100; // 9 / 4
        press_equ();
        check_result(2, "9 / 4");
        
        // 5. MÓDULO (%)
        press_sig();
        $display("\nTesting MODULO (%%) operation:");
        a = 4'b1001; b = 4'b0100; // 9 % 4
        press_equ();
        check_result(1, "9 % 4");
        
        a = 4'b1011; b = 4'b0011; // 11 % 3
        press_equ();
        check_result(2, "11 % 3");
        
        // 6. AND
        press_sig();
        $display("\nTesting AND operation:");
        a = 4'b1010; b = 4'b1100; // 1010 & 1100
        press_equ();
        check_result(8'b1000, "1010 & 1100");
        
        a = 4'b1111; b = 4'b0101; // 1111 & 0101
        press_equ();
        check_result(8'b0101, "1111 & 0101");
        
        // 7. OR
        press_sig();
        $display("\nTesting OR operation:");
        a = 4'b1010; b = 4'b1100; // 1010 | 1100
        press_equ();
        check_result(8'b1110, "1010 | 1100");
        
        a = 4'b0001; b = 4'b1000; // 0001 | 1000
        press_equ();
        check_result(8'b1001, "0001 | 1000");
        
        // 8. XOR
        press_sig();
        $display("\nTesting XOR operation:");
        a = 4'b1010; b = 4'b1100; // 1010 ^ 1100
        press_equ();
        check_result(8'b0110, "1010 ^ 1100");
        
        a = 4'b1111; b = 4'b0101; // 1111 ^ 0101
        press_equ();
        check_result(8'b1010, "1111 ^ 0101");
        
        // 9. Desplazamiento izquierda (<<)
        press_sig();
        $display("\nTesting SHIFT LEFT (<<) operation:");
        a = 4'b0001; b = 4'b0010; // 1 << 2
        press_equ();
        check_result(4'b0100, "1 << 2");
        
        a = 4'b0011; b = 4'b0001; // 3 << 1
        press_equ();
        check_result(4'b0110, "3 << 1");
        
        // 10. Desplazamiento derecha (>>)
        press_sig();
        $display("\nTesting SHIFT RIGHT (>>) operation:");
        a = 4'b1000; b = 4'b0010; // 8 >> 2
        press_equ();
        check_result(4'b0010, "8 >> 2");
        
        a = 4'b1100; b = 4'b0001; // 12 >> 1
        press_equ();
        check_result(4'b0110, "12 >> 1");
        
        $display("\nAll tests completed!");
        $finish;
    end
    
    // Helper task to press the operation change button
    task press_sig;
    begin
        @(posedge clk) sig = 1;
        @(posedge clk) sig = 0;
        #20; // Wait a little after changing operation
    end
    endtask
    
    // Helper task to press the equals button
    task press_equ;
    begin
        @(posedge clk) equ = 1;
        @(posedge clk) equ = 0;
        #20; // Wait for calculation to complete
    end
    endtask
    
    // Helper task to check the result
    task check_result;
        input integer expected;
        input string operation;
    begin
        $display("Operation: %s", operation);
        $display("Input A: %d (%b), B: %d (%b)", a, a, b, b);
        $display("Result: seg3=%b, seg2=%b, seg1=%b, seg0=%b", seg3, seg2, seg1, seg0);
        $display("Flags: %b (Zero=%b, Sign=%b, Overflow=%b, Carry=%b, Error=%b)", 
                flag, flag[0], flag[1], flag[2], flag[3], flag[4]);
        
        // For binary operations, we need to check the binary displays
        if (uut.op >= 4'b0101 && uut.op <= 4'b1001) begin
            // Check binary representation
            if ({seg3[1:0], seg2[1:0], seg1[1:0], seg0[1:0]} !== expected[3:0]) begin
                $display("ERROR: Expected binary %b, got %b%b%b%b", 
                        expected[3:0], seg3[1:0], seg2[1:0], seg1[1:0], seg0[1:0]);
            end
        end else begin
            // For arithmetic operations, check the decimal displays
            // Note: This is a simplified check - in a real testbench you would decode the 7-seg outputs
            if (uut.result !== expected[3:0]) begin
                $display("ERROR: Expected %d, got %d", expected, uut.result);
            end
        end
        $display("----------------------------------------");
    end
    endtask

endmodule