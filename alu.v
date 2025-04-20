`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Juan Saavedra Suarez
// 
// Module Name: alu.v
// Project Name: Verilog MIPS_Processor_Verilog
// Tool Versions: 
// Description: Verilog implementation of ALU for MIPS Processor
// Operands: 
// 4'b0000: AND
// 4'b0001: OR
// 4'b0010: ADD
// 4'b0011: XOR
// 4'b0110: SUB
// 4'b0111: SLT
// 4'b1100: NOR
// 
//////////////////////////////////////////////////////////////////////////////////

module alu(
    input       [31:0]      a,
    input       [31:0]      b,
    input       [3:0]       alu_op,
    input                   cin,
    output  reg [31:0]      alu_out,
    output  reg             cout,
    output  reg             overflow,
    output  reg             zero
    );

    always@(*)
    begin
        case(alu_op)
            4'b0000: {cout, alu_out} = {1'b0, a & b}; // AND
            4'b0001: {cout, alu_out} = {1'b0, a | b}; // OR
            4'b0010: {cout, alu_out} = a + b        ; // ADD
            4'b0011: {cout, alu_out} = {1'b0, a ^ b}; // XOR
            4'b0110: {cout, alu_out} = a - b        ; // SUB
            4'b0111: {cout, alu_out} =  begin         // SLT
                                            if(a < b)
                                                {1'b0, 1}
                                            else
                                                {1'b0, 0}
                                        end
            4'b1100: {cout, alu_out} = {1'b0, ~(a | b)}; // NOR
            default: {cout, alu_out} = {1'b0, 0}    ; // Default
        endcase

        overflow    =   ((alu_op === 4'b0000 && (               // ADD op
                        (a >= 0 && b >= 0 && alu_out < 0)   ||  // ADD pos + pos = neg
                        (a < 0  && b < 0  && alu_out >= 0)))||  // ADD neg + neg = pos
                        (alu_op === 4'b0110 && (                // SUB op
                        (a >= 0 && b < 0  && alu_out < 0)    || // SUB pos - neg = neg
                        (a < 0  && b >= 0 && alu_out >= 0))))   // SUB neg - pos = pos
        
        zero        =   alu_out === 32'b0 ? 1'b1 : 1'b0;
    end
endmodule