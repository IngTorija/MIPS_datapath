module Reg32(D,Q,EN,clk);
  input [31:0] D; 
  input EN, clk;
  output reg [31:0] Q;
  
  
  always @ (posedge clk)
    begin
      if(EN)
        Q <= D;
    end
endmodule