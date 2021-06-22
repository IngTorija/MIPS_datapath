module Sign_Ext(Din, Dout);
  input [15:0]Din;
  output [31:0]Dout;
  
  reg [31:0]Dout;
  
  always @(Din)
    begin
      if(Din[15]==1'b1)
        begin
        Dout[31:16]=16'hFFFF;
      	Dout[15:0]=Din[15:0];
        end
      else 
        begin
        Dout[31:16]=16'h0;
        Dout[15:0]=Din[15:0];
        end
    end
endmodule