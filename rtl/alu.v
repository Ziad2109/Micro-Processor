// ============================================================
//  alu.v  -  Arithmetic Logic Unit  (4-bit, combinational)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________   (meaty block - strong dev)
// ============================================================
module alu (
    input  wire [3:0]  a,              // data_mem.rdata
    input  wire [3:0]  b,              // acc.acc_q
    input  wire [2:0]  alu_op,         // ir_q[6:4]
    output reg  [3:0]  y,
    output reg         z_flag,         // y == 0
    output reg         c_flag          // carry / borrow
);


endmodule
