module Top_Controller_tb;

    logic btn;
    logic [7:0] seg3;
    
    // Instancia del módulo bajo prueba (DUT)
    Top_Controller uut (
        .btn(btn),
        .seg3(seg3)
    );
    
    // Proceso de prueba
    initial begin

        
        // Estado inicial
        btn = 1;
        #10
        
        // Simulación de pulsaciones del botón
        repeat (5) begin
            #10 btn = 0; // Presiona el botón
            #10 btn = 1; // Suelta el botón
        end
        
        #50;
    end
    
endmodule