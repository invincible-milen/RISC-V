module registers (
	input wire clk,
	input wire reg_write, 
	input wire [4:0] read_reg1, 
	input wire [4:0] read_reg2, 
	input wire [4:0] write_reg, 
	input wire [31:0] write_data, 
	output wire [31:0] read_data1, 
	output wire [31:0] read_data2
);
	// 32 registers
	reg [31:0] regs [31:0];
	initial regs[0] = 32'b0;

	assign read_data1 = regs[read_reg1];
	assign read_data2 = regs[read_reg2];

	always @(posedge clk) begin
		if(reg_write && write_reg != 5'd00) regs[write_reg] <= write_data;
	end
endmodule

