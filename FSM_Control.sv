module FSM_Control(
    input clk,
    input rst, 
    input [5:0] opcode,
  
    output reg ALUSrcA,
    output reg [1:0] ALUSrcB,
    output reg [1:0] ALUOp,
  	output reg IorD,
  	output reg [1:0] PCSrc,
    output reg IRWrite,
    output reg RegWrite,
  	output reg RegDst,
  	output reg MemtoReg,
  	output reg MemWrite,
    output reg PCWrite,    
	output reg branch
);
  	reg [3:0] STATE;
    parameter S0=4'd0;
    parameter S1=4'd1;
    parameter S2=4'd2;
    parameter S3=4'd3;
    parameter S4=4'd4;
    parameter S5=4'd5;
    parameter S6=4'd6;
    parameter S7=4'd7;
    parameter S8=4'd8;
    parameter S9=4'd9;
    parameter S10=4'd10;
    parameter S11=4'd11;
  

    always @(posedge clk or posedge rst)
    begin
        if(rst)
            STATE <=S0;
        else
          begin
            case(STATE)

                S0:
                        STATE <= S1;
                S1:
                  if(opcode == 6'b100011 || opcode == 6'b101011)
                        STATE <= S2;	//LW, SW
              		else if(opcode == 6'b000000)
                        STATE <= S6; //R-type
              		else if(opcode == 6'b000100)
                        STATE <= S8; //Beq
              		else if(opcode == 6'b001000)
                        STATE <= S9;	//ADDI
              		else if(opcode == 6'b000010)
                        STATE <= S11;	//Jump
                S2:
                    if(opcode == 6'b100011)
                        STATE <= S3;
              		else if (opcode == 6'b101011)
                        STATE <= S5;
                S3:
                        STATE <= S4;
              	S4:
                  		STATE <=S0;
                  
                S5:
                  		STATE <= S0;
                S6:
                  		STATE <=S7;
              	S7:
                  		STATE <= S0;
                S8:
                  		STATE <= S0;
              	S9:
                  		STATE <=S10;
              	S10:
                  		STATE <= S0;
              	S11:
                  		STATE <= S0;
                  
                 default: STATE <= S0;

            endcase
          end
    end


    always @(STATE) begin 
        case(STATE)
            S0:
              //Fetch and PC+1  
              begin 
     			IorD = 1'b0;
                MemWrite = 1'b0;
                IRWrite = 1'b1;
                RegDst = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                ALUSrcA = 1'b0;
    			ALUSrcB = 2'b01;
  				ALUOp = 2'b00;
    			branch = 1'b0;
                PCWrite = 1'b1;
                PCSrc = 2'b00;
                end
            S1:
              //Decode
                begin
    			IorD = 1'b0; 
                MemWrite = 1'b0;
    			IRWrite = 1'b0;
    			RegDst = 1'b0;
    			MemtoReg = 1'b0;
    			RegWrite = 1'b0;
                ALUSrcA = 1'b0;
    			ALUSrcB = 2'b11;
  				ALUOp = 2'b00;
    			branch = 1'b0;
                PCWrite = 1'b0;   
                PCSrc = 2'b00;
                end
            S2:
              //Mem Adr
                begin
                IorD = 1'b0;
                MemWrite = 1'b0;  
                IRWrite = 1'b0;
                RegDst = 1'b0;
    			MemtoReg = 1'b0;
                RegWrite = 1'b0;
                ALUSrcA = 1'b1;
                ALUSrcB = 2'b10;
                ALUOp = 2'b00;
                branch = 1'b0;
                PCWrite = 1'b0;
                PCSrc = 2'b00; 
                end
            S3:
              //MemRead
                begin
                IorD = 1'b1;
                MemWrite = 1'b0;  
                IRWrite = 1'b0;
                RegDst = 1'b0;
    			MemtoReg = 1'b0;
                RegWrite = 1'b0;
                ALUSrcA = 1'b1;
                ALUSrcB = 2'b10;
                ALUOp = 2'b00;
                branch = 1'b0;
                PCWrite = 1'b0;
                PCSrc = 2'b00; 
                end
            S4:
                begin
                IorD = 1'b1;
                MemWrite = 1'b0;  
                IRWrite = 1'b0;
                RegDst = 1'b0;
    			MemtoReg = 1'b1;
                RegWrite = 1'b1;
                ALUSrcA = 1'b1;
                ALUSrcB = 2'b10;
                ALUOp = 2'b00;
                branch = 1'b0;
                PCWrite = 1'b0;
                PCSrc = 2'b00; 
                end
          S5:
                begin
                IorD = 1'b1;
                MemWrite = 1'b1;  
                IRWrite = 1'b0;
                RegDst = 1'b0;
    			MemtoReg = 1'b1;
                RegWrite = 1'b0;
                ALUSrcA = 1'b1;
                ALUSrcB = 2'b10;
                ALUOp = 2'b00;
                branch = 1'b0;
                PCWrite = 1'b0;
                PCSrc = 2'b00; 
                end
          S6:
                begin
                IorD = 1'b1;
                MemWrite = 1'b0;  
                IRWrite = 1'b0;
                RegDst = 1'b0;
    			MemtoReg = 1'b1;
                RegWrite = 1'b0;
                ALUSrcA = 1'b1;
                ALUSrcB = 2'b00;
                ALUOp = 2'b10;
                branch = 1'b0;
                PCWrite = 1'b0;
                PCSrc = 2'b00;          
                end
          S7:
                begin
                IorD = 1'b1;
                MemWrite = 1'b0;  
                IRWrite = 1'b0;
                RegDst = 1'b1;
    			MemtoReg = 1'b0;
                RegWrite = 1'b1;
                ALUSrcA = 1'b1;
                ALUSrcB = 2'b00;
                ALUOp = 2'b10;
                branch = 1'b0;
                PCWrite = 1'b0;
                PCSrc = 2'b00;  
                end
          S8:
                begin
                  ALUSrcA = 1'b1;
    			  ALUSrcB = 2'b00;
  				  ALUOp = 2'b01;
  				  //IorD = 
    			PCSrc = 2'b01;
    			//IRWrite = 
    			RegWrite = 1'b0; 
  				//RegDst = 
  				//MemtoReg = 
  				//MemWrite = 
    			//PCWrite =     
	 			branch = 1'b1;
                  
                end
          S9:
                begin
                  ALUSrcA = 1'b1;
    			  ALUSrcB = 2'b10;
  				  ALUOp = 2'b00;
                  RegWrite = 1'b0;
    /*              
  	IorD = 
    PCSrc = 
    IRWrite = 
     
  	RegDst = 
  	MemtoReg = 
  	MemWrite = 
    PCWrite =     
	 branch = 
      */            
                  
                end
          S10:
                begin
               	   //ALUSrcA =
    				//ALUSrcB = 
  					//ALUOp = 
  					//IorD = 
   					 //PCSrc = 
    				//IRWrite = 
    				RegWrite = 1'b1;
  					RegDst = 1'b0;
  					MemtoReg = 1'b0;
  					//MemWrite = 
    				//PCWrite =     
	 				//branch = 
                  
                  
                end
          S11:
                begin
                  //ALUSrcA =
    //ALUSrcB = 
  	ALUOp =	2'b00; 
  	//IorD = 
    PCSrc = 2'b10;
    //IRWrite = 
    RegWrite = 1'b0;
  	//RegDst = 
  	//MemtoReg = 
  	//MemWrite = 
    PCWrite = 1'b1;    
	 //branch = 
                  
                  
                end
        endcase
    end
endmodule