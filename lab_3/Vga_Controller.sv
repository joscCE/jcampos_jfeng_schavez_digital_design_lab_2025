module Vga_Controller #(parameter N=8)(
    input logic clk, rst,
    output logic Hs, Vs,
    output logic [7:0] R, G, B,
	 output logic [9:0] Q_xz,
	 output logic [9:0] Q_yz
	 
);	 

	logic [9:0] Q_x, Q_y, D_x, D_y;         
   logic rstx,rsty;

	Counter count_y(clk, (rstx & rsty)| rst, rstx, D_y);			
	Counter count_x(clk, rstx | rst , 1'b1, D_x);
   

	Register reg_x(clk, rst, D_x, Q_x);
	Register reg_y(clk, rst, D_y, Q_y);
	
	Comparator cmp_x(Q_x, 10'd800, rstx);
	Comparator cmp_y(Q_y, 10'd525, rsty);

    
    

    // Señales de sincronización
    assign Hs = ~(Q_x >= 656 && Q_x < 752);  // Pulso horizontal
	 assign Vs = ~(Q_y >= 490 && Q_y < 492);  // Pulso vertical  
	 assign Q_xz = Q_x;
	 assign Q_yz = Q_y;
	 

    // Zona visible y color
	 
	 
	 wire visible_area;
	assign visible_area = (Q_x < 640) && (Q_y < 480);

	assign R = visible_area ? 8'hFF : 8'h00;
	assign G = visible_area ? 8'hFF : 8'h00;
	assign B = visible_area ? 8'hFF : 8'h00;

	 

//        if (Q_x >= 270 && Q_x < 370 && Q_y >= 190 && Q_y < 290) begin
//			 R = 8'hFF;
//			 G = 8'h00;
//			 B = 8'h00;
//        end else begin
//            R = 8'h00;
//            G = 8'h00;
//            B = 8'h00;
//        end


endmodule
