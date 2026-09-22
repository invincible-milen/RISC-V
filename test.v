`timescale 1ns/1ps
module tb;
	reg clk;
	
	reg pc_reset;
	cpu dut(.clk(clk), .pc_reset(pc_reset));

	always #5 clk = ~clk;

	initial begin
		$dumpfile("pc_wave.vcd");
		$dumpvars(0,tb);
		clk        = 0;
		pc_reset   = 1;

		// hold reset for one edge
		#10 pc_reset = 0;


		#40;   // let a few clock cycles pass, watch instruction words step through
		#20;

		#10;

		#10;

		#10;

		$finish;
	end
endmodule
