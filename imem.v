module instruction_memory (input wire [31:0] pc, output [31:0] instruction);
	// 4 KB memory
	reg [31:0] mem [0:1023];

	initial begin
		$readmemh("program.hex",mem);
	end

	assign instruction = mem[pc[11:2]];
endmodule
