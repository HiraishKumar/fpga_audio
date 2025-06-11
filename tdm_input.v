`timescale 1ns / 1ps
module tdm_input(
    input mclk,
    input [7:0] cnt256_n,
    input tdm_in, // Data Serial_IN
    output reg [15:0] ch1_out,
    output reg [15:0] ch2_out
);
    reg [63:0] data_reg;
    always @(posedge mclk)begin
        if(cnt256_n == 8'd0)begin               // remains constant for 256 mclk cycles
            ch1_out <= data_reg[63:48];
            ch2_out <= data_reg[31:16];
        end
        else if(cnt256_n[1:0] == 2'd2)begin     // Once every 4 mclk
            data_reg <= {data_reg[62:0], tdm_in};   // Serial in every 4 mclk
        end
        else begin
            //Latch
        end
    end
endmodule


/*
    _______| CH_2  |_______|  CH_1 |   
    |0---15|16---31|32---47|48---63| <-- tdm_in

-Every 4 Ticks (1 Cycle) - 1 Bit of tdm_in is shifted in From the RIGHT into data_reg
-Every 256 Ticks (64 Cycle) - 64 Bits of tdm_in is shifted in From The RIGHT into data_reg


    _______| CH_2  |_______|  CH_1 |   
    |0---15|16---31|32---47|48---63| <-- tdm_in
                   |<Seg_2>|<Seg_1>|


    ________| CH_2  |_______|  CH_1 |   
    |0----15|16---31|32---47|48---63| <-- tdm_in
    |<Seg_2>|<Seg_1>|                  
*/ 