module mux_2to1 (input wire sel, input wire [31:0] in0, input wire [31:0] in1, output wire [31:0] out);
	assign out = sel? in1 : in0;
endmodule

module shift(input wire [31:0] in, output wire [31:0] out);
	assign out = in<<1;
endmodule

module add_4 (input wire [31:0] in, output wire [31:0] out);
	assign out = in +4;
endmodule 

module add (input wire [31:0] in1, input wire [31:0] in2, output wire [31:0] out);
	assign out = in1 + in2;
endmodule 

module imm_gen (input wire [31:0] inst, output reg [31:0] imm);
	wire [6:0] opcode = inst[6:0];

	always @(*) begin
		case (opcode)
			// I type
			7'b0010011, 7'b0000011, 7'b1100111: imm = { {20{inst[31]} }, inst[31:20]}; 
			// S type
			7'b0100011: imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
			// B type
			7'b1100011: imm = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
			// U type
			7'b0110111, 7'b0010111: imm = {inst[31:12], 12'b0};
			// J type
			7'b1101111: imm = {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
			//R type
			default:
				imm = 32'b0;
		endcase
	end
endmodule
