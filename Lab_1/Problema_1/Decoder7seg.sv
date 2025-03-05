module Decoder7seg (
	input logic [3:0] b,a,
	output logic [7:0] seg1, seg0

);
	/* Segmentos del primer dígito */
	/* Segmentos del primer dígito */
    logic [7:0] seg0_internal;
    assign seg0_internal[7] = a[1] | a[3] | (~a[2] & ~a[0]) | (a[2] & a[0]);
    assign seg0_internal[6] = ~a[2] | (a[1] & a[0]) | (~a[1] & ~a[0]);
    assign seg0_internal[5] = ~a[1] | a[2] | a[0];
    assign seg0_internal[4] = a[3] | (~a[2] & ~a[0]) | (~a[2] & a[1]) | (a[1] & ~a[0]) | (a[2] & ~a[1] & a[0]);
    assign seg0_internal[3] = (~a[2] & ~a[0]) | (a[1] & ~a[0]);
    assign seg0_internal[2] = a[3] | (a[2] & ~a[0]) | (~a[1] & ~a[0]) | (a[2] & ~a[1]);
    assign seg0_internal[1] = a[3] | (~a[2] & a[1]) | (a[2] & ~a[0]) | (a[2] & ~a[1]);
    assign seg0_internal[0] = 1'b0;

    /* Segmentos del segundo dígito */
    logic [7:0] seg1_internal;
    assign seg1_internal[7] = ~b[0];
    assign seg1_internal[6] = 1'b1;
    assign seg1_internal[5] = 1'b1;
    assign seg1_internal[4] = ~b[0];
    assign seg1_internal[3] = ~b[0];
    assign seg1_internal[2] = ~b[0];
    assign seg1_internal[1] = 1'b0;
    assign seg1_internal[0] = 1'b0;

    // Invertimos la salida para adaptarnos a la DE10-Standard (activa baja)
    assign seg0 = ~seg0_internal;
    assign seg1 = ~seg1_internal;




endmodule