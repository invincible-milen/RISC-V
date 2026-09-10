module data_memory (input wire clk, input wire mem_write, input wire [31:0] address, input wire [31:0] write_data, output wire [31:0] read_data);
	// 4KB memory
	reg [31:0] dmem [0:1023];

	assign read_data = dmem[address[11:2]];

	always @(posedge clk) begin
		if(mem_write) dmem[address[11:2]] <= write_data;
	end
endmodule
