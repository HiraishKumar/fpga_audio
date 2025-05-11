`timescale 1ns / 1ps

module tb_top;

	// Inputs
	reg mclk;

	// Outputs
	wire tdm_in;
	wire tdm_out;
	wire bclk;
	wire wclk;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.mclk_in(mclk), 
		.tdm_in(tdm_in), 

		.wclk(wclk), 
		.bclk(bclk), 
		.tdm_out(tdm_out)
	);

	tdm_gen sig_gen(
		.bclk(bclk),
		.wclk(wclk),
		.tdm_out(tdm_in)
	);

	//Master Clock����
	initial begin
		mclk = 1;
		forever begin
			#40;
			mclk = ~mclk;
		end
	end
	
	initial begin
		#100;
        
		// Add stimulus here
	end
      
endmodule

