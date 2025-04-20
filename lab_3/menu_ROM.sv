module menu_ROM (
    input  logic [18:0] addrs,         // 19 bits para hasta 307199
    output logic [23:0] color
);

    logic [23:0] memory [0:307199];    // 640 × 480 = 307200 píxeles

    initial begin 
        $readmemh("conmenu.mem", memory); 
    end

    assign color = memory[addrs];

endmodule
