module ALU(a,b, ALUctrl,ALU_res,zero);
  input [31:0] a,b;
  input [3:0] ALUctrl;
  output reg [31:0] ALU_res;
  output zero;
  
  //assign Add = OP1 + OP2;
  assign zero = (ALU_res==0);
  
  always @ (a,b,ALUctrl) 
      begin
      case (ALUctrl)  
			4'b0000: ALU_res <= a & b; // and
			4'b0001: ALU_res <= a | b; // or
			4'b0010: ALU_res <= a + b; //add
			4'b0110: ALU_res <= a - b; //sub
			4'b0111: ALU_res <= a < b ? 1:0;//slt 
        	4'b0101: ALU_res <= ~(a | b); // nor
			default: ALU_res <= 0; 
		endcase 
	end
  
endmodule