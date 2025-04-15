module Vga_Controller #(parameter N=8,
	H_Va = 10'd640,
	H_FP = 10'd16,
	H_SycP = 10'd96,
	H_BckP = 10'd48,
	H_Total = H_Va + H_FP + H_SycP + H_BckP,
	
	V_Va = 10'd480,
	V_FP = 10'd10,
	V_SycP = 10'd2,
	V_BckP = 10'd33,
	V_Total = V_Va + V_FP + V_SycP + V_BckP


)(
    input logic clk, rst,
    output logic Hs, Vs,
	 output logic VGA_Blank, VGA_Sync_N,
    output logic [7:0] R, G, B
	 
);	 

	logic [9:0] Q_x, Q_y, D_x, D_y;         
   logic rstx,rsty;

	Counter count_y(clk, (rstx & rsty)| rst, rstx, D_y);			
	Counter count_x(clk, rstx | rst , 1'b1, D_x);
   

	Register reg_x(clk, rst, D_x, Q_x);
	Register reg_y(clk, rst, D_y, Q_y);
	
	Comparator cmp_x(Q_x, H_Total, rstx);
	Comparator cmp_y(Q_y, V_Total, rsty);

    
    

    // Señales de sincronización
    assign Hs = ~(Q_x >= H_Va + H_FP && Q_x < H_Va + H_FP + H_SycP);  
	 assign Vs = ~(Q_y >= V_Va + V_FP && Q_y < V_Va + V_FP + V_SycP); 
	 assign VGA_Sync_N = 1'b1;
	 assign VGA_Blank = (Q_x <= H_Va) && (Q_y <= V_Va);
	 
	 
	 
	 

    // Zona visible y color
	 

always_comb begin
    // Fondo negro
    R = 8'h00;
    G = 8'h00;
    B = 8'h00;

    // Corazón rojo (forma tipo pixel)
    if (
        // Parte superior del corazón (dos cuadrados)
        (Q_x >= 290 && Q_x < 310 && Q_y >= 200 && Q_y < 220) ||
        (Q_x >= 330 && Q_x < 350 && Q_y >= 200 && Q_y < 220) ||

        // Parte media del corazón (más ancha)
        (Q_x >= 280 && Q_x < 360 && Q_y >= 220 && Q_y < 240) ||

        // Parte inferior
        (Q_x >= 290 && Q_x < 350 && Q_y >= 240 && Q_y < 260) ||
        (Q_x >= 300 && Q_x < 340 && Q_y >= 260 && Q_y < 270) ||
        (Q_x >= 310 && Q_x < 330 && Q_y >= 270 && Q_y < 280)
    ) begin
        R = 8'hFF;
        G = 8'h00;
        B = 8'h00;
    end
end


endmodule
