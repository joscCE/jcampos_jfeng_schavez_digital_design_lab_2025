`timescale 1ns / 1ps

module tb_Check_win();
    // Parámetros
    parameter COLUMNS = 7;
    parameter ROWS = 6;
    
    // Señales
    logic [83:0] reg_game_M;
    logic [6:0] play_made;
    logic S;
    
    // Instancia del módulo bajo prueba
    Check_win dut (
        .reg_game_M(reg_game_M),
        .play_made(play_made),
        .S(S)
    );
    
    // Tarea para limpiar el tablero
    task clear_board;
        begin
            reg_game_M = 84'b0;
        end
    endtask
    
    // Tarea para colocar una ficha
    task place_piece;
        input [2:0] col;
        input [2:0] row;
        input player;
        begin
            reg_game_M[col*2 + row*14] = 1'b1;           // Indicador de celda ocupada
            reg_game_M[col*2 + row*14 + 1] = player;     // Jugador (0 o 1)
        end
    endtask
    
    // Tarea para verificar victoria
    task check_win;
        input [2:0] col;
        input [2:0] row;
        input player;
        input expected;
        begin
            play_made = {player, col, row};
            #10;
            $display("col=%0d, row=%0d, player=%0d. Resultado esperado=%0b, Obtenido=%0b", 
                     col, row, player, expected, S);
            if (S !== expected) begin
                $display("ERROR: Resultado incorrecto!");
                $finish;
            end
        end
    endtask
    
    // Proceso de prueba
    initial begin
        // 1. Victoria horizontal
        $display("\n# Test 1: Victoria horizontal");
        clear_board();
        place_piece(1, 0, 1);
        place_piece(2, 0, 1);
        place_piece(3, 0, 1);
        place_piece(4, 0, 1); // Movimiento ganador
        check_win(4, 0, 1, 1);
        
        // 2. Victoria vertical
        $display("\n# Test 2: Victoria vertical");
        clear_board();
        place_piece(0, 2, 0);
        place_piece(0, 3, 0);
        place_piece(0, 4, 0);
        place_piece(0, 5, 0); // Movimiento ganador
        check_win(0, 5, 0, 1);
        
        // 3. Victoria diagonal ascendente (/)
        $display("\n# Test 3: Victoria diagonal ascendente");
        clear_board();
        place_piece(1, 1, 1);
        place_piece(2, 2, 1);
        place_piece(3, 3, 1);
        place_piece(4, 4, 1); // Movimiento ganador
        check_win(4, 4, 1, 1);
        
        // 4. Victoria diagonal descendente (\)
        $display("\n# Test 4: Victoria diagonal descendente");
        clear_board();
        place_piece(3, 5, 0);
        place_piece(4, 4, 0);
        place_piece(5, 3, 0);
        place_piece(6, 2, 0); // Movimiento ganador
        check_win(6, 2, 0, 1);
        
        // 5. Sin victoria (3 en línea)
        $display("\n# Test 5: Sin victoria (3 en linea)");
        clear_board();
        place_piece(6, 0, 1);
        place_piece(6, 1, 1);
        place_piece(6, 2, 1); // Solo 3 en vertical
        check_win(6, 2, 1, 0);
        
        // 6. Caso borde: victoria en columna 6
        $display("\n# Test 6: Victoria en columna 6");
        clear_board();
        place_piece(6, 0, 1);
        place_piece(6, 1, 1);
        place_piece(6, 2, 1);
        place_piece(6, 3, 1); // Movimiento ganador
        check_win(6, 3, 1, 1);
        
        // 7. Caso borde: victoria en fila 5
        $display("\n# Test 7: Victoria en fila 5");
        clear_board();
        place_piece(0, 5, 0);
        place_piece(1, 5, 0);
        place_piece(2, 5, 0);
        place_piece(3, 5, 0); // Movimiento ganador
        check_win(3, 5, 0, 1);
        
        // 8. Victoria interrumpida por otra ficha
        $display("\n# Test 8: Victoria interrumpida");
        clear_board();
        place_piece(0, 0, 1);
        place_piece(1, 0, 1);
        place_piece(2, 0, 0); // Ficha del oponente
        place_piece(3, 0, 1);
        place_piece(4, 0, 1);
        check_win(4, 0, 1, 0);
		  
		  // Test adicional para verificar distinción entre jugador 0 y celda vacia
		  $display("\n# Test 10: Distincion jugador 0 celda vacia");
		  clear_board();
		  place_piece(0, 0, 0); // Jugador 0
		  // Dejar celdas (1,0), (2,0), (3,0) vacías
		  place_piece(4, 0, 0);
		  check_win(4, 0, 0, 0); // No deberia detectar victoria
        
        $display("\n# Fin de las pruebas");
        $finish;
    end
endmodule
