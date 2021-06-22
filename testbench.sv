`include "PC.sv"
`include "Inst_Data_Mem.sv"
`include "Register_File.sv"
`include "Sign_Ext.sv"
`include "ALU.sv"
`include "FSM_Control.sv"
`include "Mux2_1.sv"
`include "Mux4_1.sv"
`include "Reg32.sv"
`include "Mux5b_2_1.sv"
`include "ALU_ctrl_block.sv"

module MC_MIPS_TB;
  reg clk,rst;
  
  MC_MIPS UUT(.clk(clk),.rst(rst));
  
  always #1 clk = ~clk;
  
  initial begin
    $dumpfile("MC_MIPS.vcd");
    $dumpvars(0,MC_MIPS_TB);
    clk=1'b0;
    rst=1'b0;
    #1
    rst=1'b1;
    #1
    rst=1'b0;
    #5500
    $finish;
  end
endmodule