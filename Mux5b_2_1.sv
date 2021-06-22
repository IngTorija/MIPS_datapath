module Mux5b_2_1(I0,I1,S,out);
  input [4:0]I0,I1;
  input S;
  output [4:0]out;
  reg [4:0]out;
  always @ (I0,I1,S)
    begin
      case(S)
        1'b0: out = I0;
        default : out = I1;
      endcase
    end
endmodule