//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Weijie Yuan    
// Email: wyuan024@ucr.edu
// 
// Assignment name: 
// Lab section: 
// TA: 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

module controlUnit  (
    input  wire [5:0] instr_op, 
    output wire       reg_dst,   
    output wire       branch,     
    output wire       mem_read,  
    output wire       mem_to_reg,
    output wire [1:0] alu_op,        
    output wire       mem_write, 
    output wire       alu_src,    
    output wire       reg_write
    );

// ------------------------------
// Insert your solution below
// ------------------------------ 


reg [8:0] temp;

always @ (instr_op) begin
    case (instr_op)
    
        6'b000000: temp = 9'b100100010; //r
        6'b001000: temp = 9'b110100010; //imm
        6'b000100: temp = 9'bx0x000101; //beq
        6'b100011: temp = 9'b011110000; //lw
        6'b101011: temp = 9'bx1x001000; //sw
        
        
    endcase
end
assign reg_dst = temp[8];
assign alu_src = temp[7];
assign mem_to_reg = temp[6];
assign reg_write = temp[5];
assign mem_read = temp[4];
assign mem_write = temp[3];
assign branch = temp[2];
assign alu_op = temp[1:0];

endmodule
