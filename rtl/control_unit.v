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
    output reg        pc_load,
    output reg [2:0] ALU_sel
);

    always @* begin
        // Safe defaults: NOP
        acc_load = 1'b0;
        mem_write = 1'b0;
        mux_sel = 1'b0;
        pc_load = 1'b0;

        case (opcode)

    4'h0: begin   // ADD
        memR    = 1'b1;
        acc_load = 1'b1;
        mux_sel  = 1'b0;   // pick ALU result
        ALU_sel  = 3'b000; // ADD operation
    end

    4'h1: begin   // SUB
        memR    = 1'b1;
        acc_load = 1'b1;
        mux_sel  = 1'b0;
        ALU_sel  = 3'b001; // SUB operation
    end

    4'h2: begin   // AND
        memR    = 1'b1;
        acc_load = 1'b1;
        mux_sel  = 1'b0;
        ALU_sel  = 3'b011; // AND operation
    end

    4'h3: begin   // OR
        memR    = 1'b1;
        acc_load = 1'b1;
        mux_sel  = 1'b0;
        ALU_sel  = 3'b010; // OR operation
    end

    4'h4: begin   // LOAD
        memR    = 1'b1;
        acc_load = 1'b1;
        mux_sel  = 1'b1;   // pick memory data directly
        ALU_sel  = 3'b100; // PASS through
    end

    4'h5: begin   // STORE  ← should be h5 not h8
        mem_write = 1'b1;
    end

    4'h6: begin   // NOP
        // all signals stay 0
    end

    default: begin
        // unknown opcode, all stay 0
    end

endcase
    end


endmodule
