module Mux4_1(I0,I1,I2,I3,S,out);
  input [31:0]I0,I1,I2,I3;
  input [1:0]S;
  output [31:0]out;
  reg [31:0]out;
  always @ (I0,I1,I2,I3,S)
    begin
      case(S)
        2'b00: out = I0;
        2'b01: out = I1;
        2'b10: out = I2;
        default : out = I3;
      endcase
    end
endmodule