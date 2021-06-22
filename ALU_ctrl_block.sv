module ALU_ctrl_block(ALUOp,funct,ALUctrl); //
  input [1:0]ALUOp;
  input [5:0]funct;
  output reg [3:0] ALUctrl;
  
  reg [3:0] R;
  
  always@(ALUOp,funct,R)
    begin
      case(ALUOp)
        2'b00: ALUctrl = 4'b0010; //Add: sw,lw
        2'b01: ALUctrl = 4'b0110; //Substraction: beq
        2'b10: ALUctrl = R; //R-type
        default:ALUctrl= 4'b0000;
      endcase
    end
          
  always@(ALUOp,funct)
    begin
      case(funct)
        6'b100000: R = 4'b0010; //add
        6'b100010: R = 4'b0110; //substr
        6'b100100: R = 4'b0000; //AND
        6'b100101: R = 4'b0001; //OR
        6'b101010: R = 4'b0111; //slt
        6'b100111: R = 4'b0101; //nor
        6'b100110: R = 4'b1010; //xor
        default: R = 4'b0000; //AND
      endcase
    end
endmodule