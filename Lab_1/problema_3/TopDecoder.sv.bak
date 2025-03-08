module TopDecoder(
    input logic [3:0] a,
	output logic [7:0] seg1, seg0
);

	//Variables medias
	logic [3:0] y1, y0;
	
	//instacia del BCD decoder
	decoderBDC bdc_decoder(
	
		.a(a),
		.y1(y1),
		.y0(y0)
	
	);
	

    // Instanciamos el módulo Decoder7seg
		Decoder7seg seg_decoder (
        .a(y0), 
        .b(y1), 
        .seg1(seg1), 
        .seg0(seg0)
    );

endmodule
