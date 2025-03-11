module Top_Controller(
	input logic [3:0] a,b,
    input logic btn,
    output logic [7:0] seg3, seg1, seg0
	
);

    logic btn_n;
    reg [1:0] count = 2'b00;
	 
	
	 

    assign btn_n = ~btn; 

    always_ff @(posedge btn_n) begin
        if (count > 2'b10)
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

endmodule
