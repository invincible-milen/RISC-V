module alu_control (input wire [6:0] func7, input wire [2:0] func3, input wire [1:0] alu_op, output reg [3:0] control);

	localparam ALU_ADD  = 4'b0000;
	localparam ALU_SUB  = 4'b0001;
	localparam ALU_AND  = 4'b0010;
	localparam ALU_OR   = 4'b0011;
	localparam ALU_XOR  = 4'b0100;
	localparam ALU_SLL  = 4'b0101;
	localparam ALU_SRL  = 4'b0110;
	localparam ALU_SRA  = 4'b0111;
	localparam ALU_SLT  = 4'b1000;
	localparam ALU_SLTU = 4'b1001;

	always @(*) begin
		casex(alu_op)
			2'b00: control = ALU_ADD;
			2'b?1: control = ALU_SUB;
			2'b1?: begin
				case ({func3, func7})
					10'b000_0000000: control = ALU_ADD;
					10'b000_0100000: control = ALU_SUB;
					10'b100_0000000: control = ALU_XOR;
					10'b110_0000000: control = ALU_OR;
					10'b111_0000000: control = ALU_AND;
					10'b001_0000000: control = ALU_SLL;
					10'b101_0000000: control = ALU_SRL;
					10'b101_0100000: control = ALU_SRA;
					10'b010_0000000: control = ALU_SLT;
					10'b011_0000000: control = ALU_SLTU;
					default: control = ALU_ADD;
				endcase
			end
			default: control = ALU_ADD;
		endcase
	end
endmodule
