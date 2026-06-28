// ============================================================
//  acc.v  -  Accumulator  (4-bit register + flag latch)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________
// ============================================================
module acc (
    input  wire        clk,
    input  wire        rst,
    input  wire        acc_load,
    input  wire [3:0]  d,              // mux2.y
    input  wire        z_in,           // alu.z_flag
    input  wire        c_in,           // alu.c_flag
    output reg  [3:0]  acc_q,
    output reg         z_q,
    output reg         c_q
);

    // TODO (owner):
    //   rst:           {acc_q, z_q, c_q} <= 0;
    //   else acc_load: acc_q <= d; z_q <= z_in; c_q <= c_in;

endmodule
