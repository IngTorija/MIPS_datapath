module PCreg(clk,rst,d,q,EN);
  input clk,rst,EN;
  input [31:0]d;
  output[31:0]q;
  reg [31:0]q;
  
  always @(posedge clk, posedge rst)
	begin
      if(rst)begin
                  q <= 32'h00000000;
      end
      else if (EN)	begin
                  q <= d;
      end
    end
    
endmodule