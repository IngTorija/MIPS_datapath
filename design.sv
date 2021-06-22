module MC_MIPS(
  	input clk, rst
);
  
  //PC
  wire [31:0] PC_Plus1;
  wire [31:0] PC;
  //Mux Memory
  wire [31:0] Adr;
  wire [31:0] ALUOut;
  //Instr_Data_Mem
  wire [31:0] RD;
  
  //Reg Data
  wire [31:0] Data;
  //Register_File
  wire [31:0] Instr;
  wire [4:0] A1;
  wire [4:0] A2;
  wire [4:0] A3;
  wire [4:0] Dir_A3;
  wire [31:0] RD1;
  wire [31:0] RD2;
  wire [31:0] Data_WD3;
  
  wire [31:0]A;
  wire [31:0]B;
  //Sign_Extend
  wire [15:0] Imm;
  wire [31:0] SignImm;
  //ALU
  wire [31:0] SrcA;
  wire [31:0] SrcB;
  wire [31:0] ALUResult;  
  //FSM Control
  wire [1:0] ALUOp;
  wire [5:0] op;
  wire IorD;
  wire MemWrite;
  wire IRWrite;
  wire RegDst;
  wire MemtoReg;
  wire RegWrite;
  wire ALUSrcA;
  wire [1:0] ALUSrcB;
  wire [3:0] ALUControl;
  wire branch;
  wire PCWrite;
  wire [1:0] PCSrc;
  wire [31:0] PC_prima;

  wire [5:0]funct;
  wire b_and;
  wire PCEN;
  wire [31:0]PCJump;

  //Assign
  assign A1 = Instr[25:21];
  assign A2 = Instr[20:16];
  assign A3 = Instr[15:11];
  assign op = Instr[31:26];
  assign Imm = Instr[15:0];
  assign funct = Instr[5:0];
  assign PCJump = {PC[31:26],Instr[25:0]};
  
  FSM_Control Ctrl(.clk(clk),.rst(rst),.opcode(op),.IorD(IorD),.MemWrite(MemWrite),.IRWrite(IRWrite),.RegDst(RegDst),.MemtoReg(MemtoReg),.RegWrite(RegWrite),.ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .branch(branch),.PCWrite(PCWrite),.PCSrc(PCSrc),.ALUOp(ALUOp));
  
  PCreg PC1(.clk(clk),.rst(rst),.d(PC_prima),.q(PC),.EN(PCEN));

  Mux2_1 M1 (.I0(PC),.I1(ALUOut),.S(IorD),.out(Adr));
  
  Inst_Data_Memory I_D_Mem(.Address(Adr), .DataIn(B), .clk(clk), .ReadWrite(MemWrite), .DataOut(RD));
  
  Reg32	Reg_Inst(.D(RD),.Q(Instr),.EN(IRWrite),.clk(clk));
  
  Reg32	Reg_Data(.D(RD),.Q(Data),.EN(1'b1),.clk(clk));
  
  Mux2_1 M2(.I0(ALUOut),.I1(Data),.S(MemtoReg),.out(Data_WD3));
  
  Mux5b_2_1 M5b(.I0(A2),.I1(A3),.S(RegDst),.out(Dir_A3));
  
  Register_File RF(
    .A_rs(A1),
    .A_rt(A2),
    .A_rd(Dir_A3),
    .dataIn_rd(Data_WD3),
    .rw(RegWrite),
    .clk(clk),
    .rst(rst),
    .read_rs(RD1),
    .read_rt(RD2)
);
  
  Sign_Ext SE(.Din(Imm), .Dout(SignImm));
  
  Reg32 Reg_RF_RD1(.D(RD1),.Q(A),.EN(1'b1),.clk(clk));
  Reg32 Reg_RF_RD2(.D(RD2),.Q(B),.EN(1'b1),.clk(clk));
  
  Mux2_1 M3(.I0(PC),.I1(A),.S(ALUSrcA),.out(SrcA));
  
  Mux4_1 M4(.I0(B),.I1(32'h00000001),.I2(SignImm),.I3(SignImm),.S(ALUSrcB),.out(SrcB));
  
  ALU_ctrl_block ALU_ctrl_b(.ALUOp(ALUOp),.funct(funct),.ALUctrl(ALUControl));
  
  ALU ALU1(.a(SrcA),.b(SrcB), .ALUctrl(ALUControl),.ALU_res(ALUResult),.zero(zero));
  
  and(b_and,branch,zero);
  
  or(PCEN,b_and,PCWrite);
  
  Reg32 Reg_ALU(.D(ALUResult),.Q(ALUOut),.EN(1'b1),.clk(clk));
  
  Mux4_1 M5(.I0(ALUResult),.I1(ALUOut),.I2(PCJump),.I3(32'h00000000),.S(PCSrc),.out(PC_prima));
  
  
endmodule
