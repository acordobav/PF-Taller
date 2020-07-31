module Main_Decoder(input  logic[1:0] Op,
						  input  logic Funct5, Funct0,
						  input  logic [3:0] Cmd,
						  output logic Branch, RegW, MemW, MemtoReg,
											ALUSrc, ALUOp,
						  output logic [1:0] ImmSrc, 
						  output logic [2:0] RegSrc);
						  
	logic [3:0] IN;
	assign IN = {Op[1], Op[0], Funct5, Funct0};
	
	logic [10:0] OUT;
	

	always_comb begin
		casex(IN)
			4'b000?: if (Cmd == 4'b1101) OUT = 11'b0000XX10101;//DP Reg Shifts
						else OUT = 11'b0000XX10001;//DP Reg
			4'b001?: if (Cmd == 4'b1101) OUT = 11'b0001001X101;//DP Imm Shifts
						else OUT = 11'b0001001X001;//Dp Imm
			4'b01?0: OUT = 11'b0X110101000;//STR
			4'b01?1: OUT = 11'b0101011X000;//LDR
			4'b10??: OUT = 11'b1001100X010;//B
			default: OUT = 11'bX;
		endcase
	end
						  
	assign Branch = OUT[10];
	assign MemtoReg = OUT[9];
	assign MemW = OUT[8];
	assign ALUSrc = OUT[7];
	assign ImmSrc = OUT[6:5];
	assign RegW = OUT[4];
	assign RegSrc = OUT[3:1];
	assign ALUOp = OUT[0];
				  
endmodule	