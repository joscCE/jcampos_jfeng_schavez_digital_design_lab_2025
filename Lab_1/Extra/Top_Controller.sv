module Top_Controller(
	input logic [5:0] a,
	input logic [3:0] b,
   input logic btn,
	input  logic reset, dec_btn, 
   output logic [7:0] seg3, seg1, seg0
	
);

    logic btn_n;
    reg [1:0] count = 2'b00;
	 
	
	 logic [7:0] seg1_deco, seg0_deco;
    logic [7:0] seg1_adder, seg0_adder;
	  logic [7:0] seg1_sub, seg0_sub;
    logic cout_adder;
	 

    assign btn_n = ~btn; 

    always_ff @(posedge btn_n) begin
        if (count == 2'b10)
            count <= 2'b00;
        else
            count <= count + 1;

        case (count)
            2'b00: seg3 <= 8'b10000101;
            2'b01: seg3 <= 8'b00010001;
            2'b10: seg3 <= 8'b01001001;
            default: seg3 <= 8'b00000000; 
        endcase
    end
	 
	 
	 Decoder_prob1 decoder_inst (
        .a(a[3:0]),
        .seg1(seg1_deco),
        .seg0(seg0_deco)
    );
	 
	 Adder_prob3 adder_inst (
        .a(a[3:0]),
        .b(b),
        .cin(1'b0),  
        .seg1(seg1_adder),
        .seg0(seg0_adder),
        .cout(cout_adder)
    );
	 
	 
	 Sub_prob3 #(6) sub_inst (  
        .a(a),  
        .reset(reset),
        .dec_btn(dec_btn),
        .seg0(seg0_sub),
        .seg1(seg1_sub)
    );
	 
	 
	 

	 always_comb begin
		case(count)
			2'b00: begin
				seg1 = seg1_deco;
				seg0 = seg0_deco;
			end
			2'b01: begin
                seg1 = seg1_adder;
                seg0 = seg0_adder;
         end
			2'b10: begin
                seg1 = seg1_sub;
                seg0 = seg0_sub;
            end
            default: begin
                seg1 = 8'b11111111; // Apagado
                seg0 = 8'b11111111; // Apagado
            end
        endcase
		  end
	 
	
endmodule
