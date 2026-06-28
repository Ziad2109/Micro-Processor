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

    // TODO (owner): combinational ALU
    //   3'b000 ADD     y = a + b      (c_flag = carry out)
    //   3'b001 SUB     y = a - b      (c_flag = borrow)
    //   3'b010 AND     y = a & b
    //   3'b011 OR      y = a | b
    //   3'b100 PASS_A  y = a
    //   z_flag = (y == 4'b0);

endmodule
