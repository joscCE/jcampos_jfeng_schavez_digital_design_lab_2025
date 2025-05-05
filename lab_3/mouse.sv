// SystemVerilog version of the DE2_115 PS2 Mouse Controller
// - Closer to original behavior: requires iSTART to initiate
// - Converts delta movements to absolute X,Y coordinates

module mouse (
    input  logic        iRST_n,    // Active-low reset
    input  logic        iCLK_50,   // 50 MHz clock
    inout  tri          PS2_CLK,   // PS2 clock line
    inout  tri          PS2_DAT,   // PS2 data line
    output logic        oLEFBUT,   // Left button
    output logic        oMIDBUT,   // Middle button
    output logic        oRIGBUT,   // Right button
    output logic [15:0] oX,        // Absolute X position
    output logic [15:0] oY         // Absolute Y position
);

    // Parameters
    parameter logic [8:0] ENABLE_BYTE = 9'b011110100;

    // FSM states
    typedef enum logic [1:0] {LISTEN, PULLCLK, PULLDAT, TRANSMIT} state_t;
    state_t cur_state, next_state;

    // Clock divider for ~97.656 kHz PS2 sampling clock
    logic [9:0] clk_div;
    logic       ps2_clk_slow;
    always_ff @(posedge iCLK_50) clk_div <= clk_div + 1;
    assign ps2_clk_slow = clk_div[8];

    // PS2 I/O control
    logic ce, de;
    logic ps2_clk_out, ps2_dat_out;
    logic ps2_clk_in, ps2_dat_in;
    logic ps2_clk_sync0, ps2_clk_sync1;
    logic ps2_dat_sync0, ps2_dat_sync1;

    assign PS2_CLK     = ce    ? ps2_clk_out : 1'bz;
    assign PS2_DAT     = de    ? ps2_dat_out : 1'bz;
    assign ps2_clk_out = 1'b0;
    assign ps2_dat_out = shift_reg[0];
    assign ps2_clk_sync0 = ce   ? 1'b1       : PS2_CLK;
    assign ps2_dat_sync0 = de   ? 1'b1       : PS2_DAT;

    always_ff @(posedge ps2_clk_slow) begin
        ps2_clk_sync1 <= ps2_clk_sync0;
        ps2_dat_sync1 <= ps2_dat_sync0;
    end
    assign ps2_clk_in = ps2_clk_sync1;
    assign ps2_dat_in = ps2_dat_sync1;

    // Counters
    logic [7:0]  cnt;
    logic        flag_idle;
    logic [5:0]  ct;
    logic [3:0]  byte_count;
    logic [3:0]  delay_count;
    logic [9:0]  dout_reg;
    logic [32:0] shift_reg;

    // Button and coordinates
    logic left_btn, mid_btn, right_btn;
    logic [15:0] x_coord, y_coord;
    logic [7:0]  x_latch, y_latch;

    // IDLE detection (8-bit counter)
    always_ff @(posedge ps2_clk_slow) begin
        if ({ps2_clk_in, ps2_dat_in} == 2'b11)
            cnt <= cnt + 1;
        else
            cnt <= 8'd0;
    end
    assign flag_idle = (cnt == 8'hFF);

    // bit count, resets on idle
    always_ff @(posedge ps2_clk_in or posedge flag_idle) begin
        if (flag_idle)
            ct <= 0;
        else
            ct <= ct + 1;
    end

    // FSM next state
    always_comb begin
        ce = 0; de = 0;
        next_state = cur_state;
        unique case (cur_state)
            LISTEN: begin
                if (flag_idle)
                    next_state = PULLCLK;
            end
            PULLCLK: begin
                ce = 1;
                if (delay_count == 4'd12)
                    next_state = PULLDAT;
            end
            PULLDAT: begin
                ce = 1; de = 1;
                next_state = TRANSMIT;
            end
            TRANSMIT: begin
                de = 1;
                if (byte_count == 4'd10)
                    next_state = LISTEN;
            end
        endcase
    end

    // FSM state register
    always_ff @(posedge ps2_clk_slow or negedge iRST_n) begin
        if (!iRST_n)
            cur_state <= LISTEN;
        else
            cur_state <= next_state;
    end

    // Delay for PULLCLK
    always_ff @(posedge ps2_clk_slow) begin
        if (cur_state == PULLCLK)
            delay_count <= delay_count + 1;
        else
            delay_count <= 0;
    end

    // Transmit shift and byte counter
    always_ff @(negedge ps2_clk_in) begin
        if (cur_state == TRANSMIT) begin
            dout_reg   <= {1'b0, dout_reg[9:1]};
            byte_count <= byte_count + 1;
        end else begin
            dout_reg   <= {ENABLE_BYTE, 1'b0};
            byte_count <= 0;
        end
    end

    // Receive shift
    always_ff @(negedge ps2_clk_in) begin
        if (cur_state == LISTEN)
            shift_reg <= {ps2_dat_in, shift_reg[32:1]};
    end

    // Latch and accumulate deltas
    always_ff @(posedge ps2_clk_slow or negedge iRST_n) begin
        if (!iRST_n) begin
            left_btn <= 0; mid_btn <= 0; right_btn <= 0;
            x_coord <= 0; y_coord <= 0;
        end else if ((cnt == 8'd30) && (ct[5] || ct[4])) begin
            left_btn  <= shift_reg[1];
            right_btn <= shift_reg[2];
            mid_btn   <= shift_reg[3];
            x_latch   <= shift_reg[19:12];
            y_latch   <= shift_reg[30:23];
            x_coord   <= x_coord + $signed(shift_reg[19:12]);
            y_coord   <= y_coord + $signed(shift_reg[30:23]);
        end
    end

    // Outputs
    assign oLEFBUT = left_btn;
    assign oMIDBUT = mid_btn;
    assign oRIGBUT = right_btn;
    assign oX      = x_coord;
    assign oY      = y_coord;

endmodule
