// ============================================================
//  control_unit.v  -  Control Unit  (combinational decoder)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________
// ============================================================
module control_unit (
    input  wire [3:0] opcode,
    input  wire       z_flag,
    input  wire       c_flag,
    output reg        acc_load,
    output reg        mem_write,
    output reg        mux_sel,
    output reg        pc_load
);

    always @* begin
        // Safe defaults: NOP
        acc_load = 1'b0;
        mem_write = 1'b0;
        mux_sel = 1'b0;
        pc_load = 1'b0;

        case (opcode)
            4'h0, // ADD
            4'h1, // SUB
            4'h2, // AND
            4'h3, // OR
            4'h4: // LOAD
                acc_load = 1'b1;

            4'h8: // STORE
                mem_write = 1'b1;

            default: begin
                // Undefined opcodes and F behave as NOP.
            end
        endcase
    end


endmodule
