module data_path (
	input wire clk,
	input wire reg_write,
	input wire alu_src,
	input wire [3:0] alu_op,
	input wire mem_write,
	input wire mem_to_reg,
	input wire pc_src,
	input wire pc_reset
);

	wire [31:0] pc_in, pc_out;
	program_counter pc(.pc_in(pc_in), .clk(clk), .reset(pc_reset), .pc_out(pc_out));

	wire [31:0] pc_4;
	add_4 pc_add4(.in(pc_out), .out(pc_4));

	wire [31:0] inst;
	instruction_memory imem(.pc(pc_out), .instruction(inst));

	wire [31:0] read_data1, read_data2, write_data;
	registers reg_file(.clk(clk), .reg_write(reg_write), .read_reg1(inst[19:15]), .read_reg2(inst[24:20]), .write_reg(inst[11:7]), .write_data(write_data), .read_data1(read_data1), .read_data2(read_data2));

	wire [31:0] imm;
	imm_gen immgen(.inst(inst), .imm(imm));

	wire [31:0] alu_in2;
	mux_2to1 alu_mux(.sel(alu_src), .in0(read_data2), .in1(imm), .out(alu_in2));

	wire [31:0] alu_out;
	wire zero;
	alu a(.a(read_data1), .b(alu_in2), .alu_op(alu_op), .result(alu_out), .zero(zero));

	wire [31:0] mem_data;
	data_memory dmem(.clk(clk), .mem_write(mem_write), .address(alu_out), .write_data(read_data2), .read_data(mem_data));

	mux_2to1 mem_reg(.sel(mem_to_reg), .in0(alu_out), .in1(mem_data), .out(write_data));

	wire [31:0] pc_offset;
	shift shifter(.in(imm), .out(pc_offset));

	wire [31:0] pc_o;
	add pc_add(.in1(pc_out), .in2(pc_offset), .out(pc_o));

	mux_2to1 pc_mux(.sel(pc_src), .in0(pc_4), .in1(pc_o), .out(pc_in));

endmodule

