`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Juan Saavedra Suarez
// 
// Module Name: ctrl_unit.v
// Project Name: Verilog MIPS_Processor_Verilog
// Tool Versions: 
// Description: Verilog implementation of Control Unit for MIPS Processor
// Signals
// 
//////////////////////////////////////////////////////////////////////////////////

module ctrl_unit(
    input               clk,
    input               rst,
    input       [5:0]   ctrl_op,
    output reg  [5:0]   alu_op,     // Opcode for ALU
    output reg          alu_oe,     // High: ALU outputs to CPU bus
    output reg          rf_en,      // High: reg file inputs data from CPU bus
    output reg          rf_oe,      // High: reg file outputs data to CPU bus
    output reg          rd_or_rt,   // High: use Rt for dest reg, Low: use Rd
    output reg          rs_or_rt,   // High: use Rt for source reg, Low: use Rd
    output reg          a_en,       // High: Reg A inputs from CPU bus
    output reg          b_en,       // High: Reg B inputs from CPU bus
    output reg          seu_oe,     // High: SEU outputs to CPU bus
    output reg          pc_en,      // High: PC inputs from CPU bus
    output reg          pc_oe,      // High: PC outputs to CPU bus
    output reg          ir_en,      // High: IR inputs from CPU bus
    output reg          mar_en,     // High: MAR inputs from CPU bus
    output reg          mdr_en,     // High: MDR inputs from CPU bus
    output reg          mdr_oe,     // High: MDR outputs to CPU bus
    );

    /***************************************************************************
    * States for FSM
    ***************************************************************************/

    reg [3:0]       state,          // Current state for FSM
                    nextstate;      // Holds next state for FSM
    
    reg [2:0]       exec;           // Execution flag for multi-clock cycle instructions

    localparam  RESET   = 4'b0000,
                FETCH   = 4'b0001,
                DECODE  = 4'b0010,
                AND     = 4'b0011,
                OR      = 4'b0100,
                ADD     = 4'b0101,
                XOR     = 4'b0110,
                SUB     = 4'b0111,
                SLT     = 4'b1000,
                ERROR   = 4'b1111;

    /***************************************************************************
    * Sequential logic for FSM
    ***************************************************************************/
    
    always@(posedge clk or posedge rst)
        if(rst)
            state = RESET
        else
            state = nextstate

    always@(state)
        casez({state,exec})
            7'b0000_000: // RESET 
            begin
                alu_op      = 6'b0;     alu_oe      = 1'b0;
                rf_en       = 1'b0;     rf_oe       = 1'b0;
                rd_or_rt    = 1'b0;     rs_or_rt    = 1'b0;
                a_en        = 1'b0;     b_en        = 1'b0;
                seu_oe      = 1'b0;
                pc_en       = 1'b0;     pc_oe       = 1'b0;
                ir_en       = 1'b0;
                mar_en      = 1'b0;     mdr_en      = 1'b0;   
                mdr_oe      = 1'b0;
                nextstate = FETCH;
            end; 
            7'b0001_000: // FETCH
            begin 
                alu_op      = 6'b0;     alu_oe      = 1'b0;
                rf_en       = 1'b0;     rf_oe       = 1'b0;
                rd_or_rt    = 1'b0;     rs_or_rt    = 1'b0;
                a_en        = 1'b0;     b_en        = 1'b0;
                seu_oe      = 1'b0;
                pc_en       = 1'b0;     pc_oe       = 1'b0;
                ir_en       = 1'b0;
                mar_en      = 1'b0;     mdr_en      = 1'b0;   
                mdr_oe      = 1'b0;
                nextstate = FETCH;
            end;
            7'b0010_000: // DECODE 
            begin 
                alu_op      = 6'b0;     alu_oe      = 1'b0;
                rf_en       = 1'b0;     rf_oe       = 1'b0;
                rd_or_rt    = 1'b0;     rs_or_rt    = 1'b0;
                a_en        = 1'b0;     b_en        = 1'b0;
                seu_oe      = 1'b0;
                pc_en       = 1'b0;     pc_oe       = 1'b0;
                ir_en       = 1'b0;
                mar_en      = 1'b0;     mdr_en      = 1'b0;   
                mdr_oe      = 1'b0;
                nextstate = FETCH;
            end;
            7'b0011_000: // AND 
            begin 
                alu_op      = 6'b0;     alu_oe      = 1'b0;
                rf_en       = 1'b0;     rf_oe       = 1'b0;
                rd_or_rt    = 1'b0;     rs_or_rt    = 1'b0;
                a_en        = 1'b0;     b_en        = 1'b0;
                seu_oe      = 1'b0;
                pc_en       = 1'b0;     pc_oe       = 1'b0;
                ir_en       = 1'b0;
                mar_en      = 1'b0;     mdr_en      = 1'b0;   
                mdr_oe      = 1'b0;
                nextstate = FETCH;
            end;
            7'b0100_000: // OR 
            begin 
                alu_op      = 6'b0;     alu_oe      = 1'b0;
                rf_en       = 1'b0;     rf_oe       = 1'b0;
                rd_or_rt    = 1'b0;     rs_or_rt    = 1'b0;
                a_en        = 1'b0;     b_en        = 1'b0;
                seu_oe      = 1'b0;
                pc_en       = 1'b0;     pc_oe       = 1'b0;
                ir_en       = 1'b0;
                mar_en      = 1'b0;     mdr_en      = 1'b0;   
                mdr_oe      = 1'b0;
                nextstate = FETCH;
            end; 
            7'b0101_000: // ADD
            begin 
                alu_op      = 6'b0;     alu_oe      = 1'b0;
                rf_en       = 1'b0;     rf_oe       = 1'b0;
                rd_or_rt    = 1'b0;     rs_or_rt    = 1'b0;
                a_en        = 1'b0;     b_en        = 1'b0;
                seu_oe      = 1'b0;
                pc_en       = 1'b0;     pc_oe       = 1'b0;
                ir_en       = 1'b0;
                mar_en      = 1'b0;     mdr_en      = 1'b0;   
                mdr_oe      = 1'b0;
                nextstate = FETCH;
            end;
            7'b0110_000: // XOR
            begin 
                alu_op      = 6'b0;     alu_oe      = 1'b0;
                rf_en       = 1'b0;     rf_oe       = 1'b0;
                rd_or_rt    = 1'b0;     rs_or_rt    = 1'b0;
                a_en        = 1'b0;     b_en        = 1'b0;
                seu_oe      = 1'b0;
                pc_en       = 1'b0;     pc_oe       = 1'b0;
                ir_en       = 1'b0;
                mar_en      = 1'b0;     mdr_en      = 1'b0;   
                mdr_oe      = 1'b0;
                nextstate = FETCH;
            end;
            7'b0111_000: // SUB 
            begin 
                alu_op      = 6'b0;     alu_oe      = 1'b0;
                rf_en       = 1'b0;     rf_oe       = 1'b0;
                rd_or_rt    = 1'b0;     rs_or_rt    = 1'b0;
                a_en        = 1'b0;     b_en        = 1'b0;
                seu_oe      = 1'b0;
                pc_en       = 1'b0;     pc_oe       = 1'b0;
                ir_en       = 1'b0;
                mar_en      = 1'b0;     mdr_en      = 1'b0;   
                mdr_oe      = 1'b0;
                nextstate = FETCH;
            end;
            7'b1000_000: // SLT 
            begin 
                alu_op      = 6'b0;     alu_oe      = 1'b0;
                rf_en       = 1'b0;     rf_oe       = 1'b0;
                rd_or_rt    = 1'b0;     rs_or_rt    = 1'b0;
                a_en        = 1'b0;     b_en        = 1'b0;
                seu_oe      = 1'b0;
                pc_en       = 1'b0;     pc_oe       = 1'b0;
                ir_en       = 1'b0;
                mar_en      = 1'b0;     mdr_en      = 1'b0;   
                mdr_oe      = 1'b0;
                nextstate = FETCH;
            end;
            7'b1111_000: // ERROR
            begin 
                alu_op      = 6'b0;     alu_oe      = 1'b0;
                rf_en       = 1'b0;     rf_oe       = 1'b0;
                rd_or_rt    = 1'b0;     rs_or_rt    = 1'b0;
                a_en        = 1'b0;     b_en        = 1'b0;
                seu_oe      = 1'b0;
                pc_en       = 1'b0;     pc_oe       = 1'b0;
                ir_en       = 1'b0;
                mar_en      = 1'b0;     mdr_en      = 1'b0;   
                mdr_oe      = 1'b0;
                nextstate = FETCH;
            end;
        endcase
        
endmodule