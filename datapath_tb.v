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

`timescale 1ns / 1ps

module datapath_tb;
    // Inputs
    reg clk; 
    reg [5:0] instr_op;    
    reg [5:0] instr_field;

    wire [8:0] result;
    wire [3:0] alu_result;

    reg [8:0] R;
    reg [3:0] R_alu;

    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("lab04.vcd");
        $dumpvars(0);
    end
    
    // ---------------------------------------------------
    // Instantiate the Units Under Test (UUT)
    // --------------------------------------------------- 
    controlUnit uut (
        .instr_op  (instr_op), 
        .reg_dst   (result[8]), 
        .alu_src   (result[7]), 
        .mem_to_reg(result[6]), 
        .reg_write (result[5]), 
        .mem_read  (result[4]), 
        .mem_write (result[3]), 
        .branch    (result[2]), 
        .alu_op    (result[1:0])
    );

    aluControlUnit uut2 (
        .alu_op         (result[1:0]),
        .instruction_5_0(instr_field),
        .alu_out        (alu_result)
    );
    initial begin 
        clk = 0;
        forever begin 
            clk = ~clk; #10; 
        end 
    end
     
    integer failedTests = 0;
    integer totalTests = 0;
    initial begin
        // Reset
        @(posedge clk); // Wait for first clock out of reset 
        #10; // Wait 

        // -------------------------------------------------------
        // Test group 1: Control Unit
        // -------------------------------------------------------
        $display("Test Group 1: Testing Control unit... ");

        $write("\tTest Case 1.1: R-format ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        R = { 9'b100100010 }; 
        #100; // Wait
        if (R != result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        // -------------------------------------------------------
        // More Control Unit tests jere
        // -------------------------------------------------------

        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b100011;
        R = { 9'b011110000 }; 
        #100; // Wait
        if (R != result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end


        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b101011;
        R = { 9'bx1x001000 }; 
        #100; // Wait
        if (R != result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end


        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000100;
        R = { 9'bx0x000101 }; 
        #100; // Wait
        if (R != result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b001000;
        R = { 9'b110100010 }; 
        #100; // Wait
        if (R != result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end
        // -------------------------------------------------------
        // Test group 2: ALU Control Unit
        // -------------------------------------------------------
        $display("\nTest Group 2: Testing ALU Control unit... ");

        $write("\tTest Case 2.1: R-type (add) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        instr_field = 6'b100000;
        R_alu = { 4'b0010 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end
        $write("\tTest Case 2.2: R-type (sub) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        instr_field = 6'b100010;
        R_alu = { 4'b0110 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end
        $write("\tTest Case 2.3: R-type (and) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        instr_field = 6'b100100;
        R_alu = { 4'b0000 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end
        $write("\tTest Case 2.4: R-type (or) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        instr_field = 6'b100101;
        R_alu = { 4'b0001 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end
        $write("\tTest Case 2.5: R-type (nor) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        instr_field = 6'b100111;
        R_alu = { 4'b1100 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end
        $write("\tTest Case 2.6: R-type (slt) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        instr_field = 6'b101010;
        R_alu = { 4'b0111 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end
        $write("\tTest Case 2.7: lw ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b100011;
        instr_field = 6'b101010;
        R_alu = { 4'b0010 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end
        $write("\tTest Case 2.8: sw ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b101011;
        instr_field = 6'b101010;
        R_alu = { 4'b0010 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end
        $write("\tTest Case 2.9: beq ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000100;
        instr_field = 6'b101010;
        R_alu = { 4'b0110 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.10: R-type (adding an imm) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b001000;
        instr_field = 6'b100000;
        R_alu = { 4'b0010 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end
        // -------------------------------------------------------
        // More ALU Control Unit tests jere
        // -------------------------------------------------------

        // --------------------------------------------------------------
        // End testing
        // --------------------------------------------------------------
        $write("\n--------------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests",totalTests-failedTests,totalTests);
        $write("\n--------------------------------------------------------------\n");
        $finish();
    end
endmodule

