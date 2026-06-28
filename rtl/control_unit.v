// ============================================================
//  control_unit.v  -  Control Unit  (combinational decoder)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________
// ============================================================
module control_unit (
    input  wire [3:0]  opcode,
    input  wire        z_flag,         // unused this ISA
    input  wire        c_flag,         // unused this ISA
    output reg         acc_load,
    output reg         mem_write,
    output reg         mux_sel,
    output reg         pc_load
);

  

endmodule
