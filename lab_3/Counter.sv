module Counter #(parameter N=10)(
    input logic clk,
    input logic rst,
    input logic en,
    output logic [N-1:0] Q
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            Q <= 10'h00;  // asigna cero compatible con cualquier tamaño
        else if (en)
            Q <= Q + 1'b1;
    end

endmodule
