module Register_File (
  input [4:0] A_rs,A_rt,A_rd,
  input [31:0] dataIn_rd,
  input rw,
  input clk,rst,
  output reg [31:0] read_rs,
  output reg [31:0] read_rt
);
  reg [31:0] RAM[31:0];	//32 x 32 memory
  integer i;
  integer f_id; 			// Variable for file descriptor handle
  string line; 			// String value read from the file
  
  initial 
    begin    
    $readmemh ( "C:/Users/Torij/Documents/CURSO_INTEL_INAOE/DiseñoDigital/Multicycle_MIPS/Multicycle_MIPS_project_final/Register_File.txt" , RAM);
  	end 
  
  always @(posedge clk)
	begin
      if (rw == 1'b1) 
		begin
          RAM[A_rd] <= dataIn_rd;
          //$display("dataIn_rd = %h",dataIn_rd);
          f_id = $fopen ("Register_File.txt", "w");
          for (i = 0; i < 32; i = i+1) begin
  			$fdisplay (f_id, "RAM[%d]= %h",i,RAM[i]);
   		  end
    	  $fclose(f_id);
		end
	end
	
  always @(*)
	begin
		read_rs <= RAM[A_rs];
      	read_rt <= RAM[A_rt];
	end
  
 /*always @(posedge clk)
  	begin
      for(i = 0; i<32;i = i+1)
      begin
        $display("RAM[%d]= %h",i,RAM[i]);
      end
     $display("\n");
  	end*/

endmodule