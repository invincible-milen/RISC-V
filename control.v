module control(
	input [6:0] op_code, 
	output reg branch, 
	output reg memtoreg, 
	output reg [1:0] aluop, 
	output reg memwrite, 
	output reg alusrc, 
	output reg regwrite
);

	localparam RTYPE = 7'b0110011;
	localparam LOAD = 7'b0000011;
	localparam STORE = 7'b0100011;
	localparam BRANCH = 7'b1100011;

	always @(*) begin
		branch = 1'b0;
		memtoreg = 1'b0;
		aluop = 2'b00;
		memwrite = 1'b0;
		alusrc = 1'b0;
		regwrite = 1'b0;

		case(op_code)
			RTYPE: begin
				regwrite = 1'b1;
				alusrc = 1'b0;
				memtoreg = 1'b0;
				aluop = 2'b10;
			end
			LOAD: begin
				regwrite = 1'b1;
				alusrc = 1'b1;
				memtoreg = 1'b1;
				aluop = 2'b00;
			end
			STORE: begin
				alusrc = 1'b1;
				memwrite = 1'b1;
				aluop = 2'b00;
			end
			BRANCH: begin
				alusrc = 1'b0;
				branch = 1'b1;
				aluop = 2'b01;
			end
			default: begin
				branch = 1'b0;
				memtoreg = 1'b0;
				aluop = 2'b00;
				memwrite = 1'b0;
				alusrc = 1'b0;
				regwrite = 1'b0;
			end
		endcase
	end
endmodule
