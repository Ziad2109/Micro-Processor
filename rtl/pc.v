// ============================================================
//  pc.v  -  Program Counter  (sequential)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________
// ============================================================
module pc (
    input  wire        clk,
    input  wire        rst,
    input  wire        pc_load,        // jump enable (unused - tie 0)
    input  wire [7:0]  pc_jump_addr,   // jump target (unused)
    output reg  [7:0]  pc_q
);

    // TODO (owner): up-counter, synchronous active-high reset
    //   rst:          pc_q <= 8'b0;
    //   else pc_load: pc_q <= pc_jump_addr;   // unused this ISA
    //   else:         pc_q <= pc_q + 1'b1;

endmodule
