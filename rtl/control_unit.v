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

    // TODO (owner): decode opcode -> control strobes.
    //   Default everything to 0 first to PREVENT inferred latches.
    // always @(*) begin
    //   {acc_load, mem_write, mux_sel, pc_load} = 4'b0000;
    //   case (opcode)
    //     4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100: acc_load  = 1'b1; // ADD/SUB/AND/OR/LOAD
    //     4'b1000:                                     mem_write = 1'b1; // STORE
    //     default: ;                                                     // NOP / unused
    //   endcase
    // end

endmodule
