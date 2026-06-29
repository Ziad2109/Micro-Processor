// ============================================================
//  ir.v  -  Instruction Register  (8-bit register)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________
// ============================================================
module ir (
    input  wire       clk,
    input  wire       rst,
    input  wire [7:0] instr,
    output reg  [7:0] ir_q
);

    always @(posedge clk) begin
        if (rst)
            ir_q <= 8'hF0; // NOP during reset
        else
            ir_q <= instr;
    end

endmodule
