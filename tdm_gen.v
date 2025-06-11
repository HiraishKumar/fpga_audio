`timescale 1ns / 1ps
// `include "tdm_input.v"
// `include "audio_clkgen.v"
// `include "audio_processing.v"
// `include "tdm_output.v"
// `include "top.v"


module tdm_gen(
    input bclk,     // 1:2   mclk
    input wclk,     // 1:128 mclk
    output tdm_out
);
    reg [1:0] wc_ff;
    reg [5:0] bclk_cnt;             // max bclk_cnt = 63 decimal
    parameter FIX_DATA = 32'hABCD0000;

    assign tdm_out = FIX_DATA[bclk_cnt[4:0]];

    always @(posedge bclk)begin
        wc_ff <= {wc_ff[0], wclk};  // Serial Shifts in the wclk from the right
    end

    always @(negedge bclk)begin
        if(wc_ff == 2'b01)          // wclk posedge detector offset by one bclk
            bclk_cnt <= 6'd62;      // 0b111110 bclk_cnt[4:0] = 30 here, so ouputs 30th bit of FIX_DATA
                                    // Cycles through FIX_DATA twice in the time for next wclk posedge
		else begin
			bclk_cnt <= bclk_cnt - 6'd1;
		end
    end

endmodule
