module Adder #(parameter N = 4) (

    input [N-1:0] A, B,
    input Mode, en,

    output logic [N-1:0] C   // <-- salida logic
);

always_comb begin
    if (en) begin
        if (~Mode)
            C = A + B;
        else
            C = A - B;
    end else begin
        C = 0;    // <-- importante: darle un valor default si no está habilitado
    end
end

endmodule
