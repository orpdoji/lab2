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

module aluControlUnit (
    input  wire [1:0] alu_op, 
    input  wire [5:0] instruction_5_0, 
    output wire [3:0] alu_out

    );

// ------------------------------
// Insert your solution below
// ------------------------------ 
reg [3:0] aluoutput;

always @ (alu_op, instruction_5_0) begin
    casex ({alu_op, instruction_5_0})
        8'b1xxx0100: aluoutput = 4'b0000;
        8'b1xxx0101: aluoutput = 4'b0001; 
        8'b00xxxxxx: aluoutput = 4'b0010;
        8'b1xxx0000: aluoutput = 4'b0010;
        8'bx1xxxxxx: aluoutput = 4'b0110;
        8'b1xxx0010: aluoutput = 4'b0110;
        8'b1xxx1010: aluoutput = 4'b0111;
        8'b1xxx0111: aluoutput = 4'b1100;
    endcase
end

assign alu_out = aluoutput;

endmodule

