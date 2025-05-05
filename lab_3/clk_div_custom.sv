module clk_div_custom (
    input  logic clk,         // clk de 50MHz
    input  logic rst,         // reset
    output logic clk_out      // clk de 97.65625kHz
);

    // Contador hasta 255
    logic [7:0] counter_val, next_val;

    // Instancia de tu módulo Register como contador
    Register #(8) counter (
        .clk(clk),
        .rst(rst),
        .D(next_val),
        .en(1'b1),
        .Q(counter_val)
    );

    // Lógica de conteo
    always_comb begin
        if (counter_val == 8'd255)
            next_val = 8'd0;
        else
            next_val = counter_val + 1;
    end

    // Generación del clk_out con toggle
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            clk_out <= 0;
        else if (counter_val == 8'd255)
            clk_out <= ~clk_out;
    end

endmodule
