module cpu(input wire clk, input pc_reset);

	wire [6:0] op_code;
	wire zero;
	wire branch;
	wire pc_src; 
	wire memtoreg;
	wire [1:0] aluop;
	wire memwrite;
	wire alusrc;
	wire regwrite;

	datapath dp(.clk(clk), .reg_write(regwrite), .alu_src(alusrc), .alu_op(aluop), .mem_write(memwrite), .mem_to_reg(memtoreg), .pc_src(pc_src), .pc_reset(pc_reset), .op_code(op_code),.zero(zero));
	control con(.op_code(op_code), .branch(branch), .memtoreg(memtoreg), .aluop(aluop), .memwrite(memwrite), .alusrc(alusrc), .regwrite(regwrite));

	assign pc_src = branch & zero;
endmodule
