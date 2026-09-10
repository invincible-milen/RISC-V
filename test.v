`timescale 1ns/1ps
module tb;
	reg clk, reg_write, alu_src, mem_write, mem_to_reg, pc_src, pc_reset;
	reg [3:0] alu_op;
	
	data_path dut(.clk(clk), .reg_write(reg_write), .alu_src(alu_src), .alu_op(alu_op), .mem_write(mem_write), .mem_to_reg(mem_to_reg), .pc_src(pc_src), .pc_reset(pc_reset));

	always #5 clk = ~clk;

	initial begin
		$dumpfile("pc_wave.vcd");
		$dumpvars(0,tb);
		clk        = 0;
		pc_reset   = 1;
		reg_write  = 0;
		alu_src    = 0;
		alu_op     = 4'b0000;
		mem_write  = 0;
		mem_to_reg = 0;
		pc_src     = 0;

		// hold reset for one edge
		#10 pc_reset = 0;

		// Example: exercise an R-type-style ALU op (e.g. add) for a few cycles
		reg_write  = 1;
		alu_src    = 0;      // ALU src2 = read_data2 (register-register)
		alu_op     = 4'b0000; // add
		mem_write  = 0;
		mem_to_reg = 0;      // write-back from ALU result
		pc_src     = 0;      // sequential PC (pc+4)

		#40;   // let a few clock cycles pass, watch instruction words step through

		// Example: exercise an I-type-style op (immediate as ALU src2)
		alu_src = 1;
		#20;

		// Example: exercise a memory write
		mem_write  = 1;
		mem_to_reg = 0;
		#10;

		// Example: exercise a memory read / write-back from memory
		mem_write  = 0;
		mem_to_reg = 1;
		#10;

		// Example: force a branch taken
		pc_src = 1;
		#10;

		$finish;
	end
endmodule
