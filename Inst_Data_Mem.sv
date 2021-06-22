module Inst_Data_Memory(Address, DataIn, clk, ReadWrite, DataOut);
  input [31:0] Address;
  input [31:0] DataIn;
  input clk;
  input ReadWrite;
  output reg [31:0]DataOut;
  
  reg [31:0] Mem [1023:0];
 integer i;
initial
  begin    
    $readmemh ( "C:/Users/Torij/Documents/CURSO_INTEL_INAOE/DiseñoDigital/Multicycle_MIPS/Multicycle_MIPS_project_final/Memory.txt" , Mem);
  end 
  
  always @ (*) begin
    //if(ReadWrite)			// Read Data
      DataOut <= Mem[Address];
  end
 
  always @ (posedge clk) begin
    if(ReadWrite)
     Mem[Address] = DataIn;  //Write data
  
  end
  
   /* always @(posedge clk)
  	begin
      for(i = 0; i<32;i = i+1)
      begin
        $display("DataMem[%d]= %h",i,Mem[i]);
      end
     $display("\n");
  	end*/
  
  
  
endmodule
