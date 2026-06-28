// ============================================================
//  ir.v  -  Instruction Register  (8-bit register)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________
// ============================================================
module ir (
    input  wire        clk,
    input  wire        rst,
    input  wire [7:0]  instr,
    output reg  [7:0]  ir_q
);

    // TODO (owner): latch the instruction each clock
    //   rst:  ir_q <= 8'b0;
    //   else: ir_q <= instr;

endmodule
