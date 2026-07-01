// ============================================================
//  ir.v  -  Instruction Register  (8-bit register)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: Basel
// ============================================================

module ir (
    input  wire        clk,
    input  wire        rst,
    input  wire        load,      // CU tells IR when to fetch new instruction
    input  wire [7:0]  instr,     // 8-bit instruction from Program Memory

    output reg  [7:0]  ir_q,      // full instruction held (for inspection)
    output reg  [2:0]  alu_op,    // instr[7:5] → ALU operation select
    output reg  [3:0]  in_port    // instr[3:0] → Mux (immediate / address)
);

    always @(posedge clk or posedge rst) begin

        if (rst) begin
            // Reset: wipe everything to NOP safe state
            ir_q    <= 8'hF0;    // NOP instruction
            alu_op  <= 3'b000;
            in_port <= 4'b0000;
        end

        else if (load) begin
            // Fetch: grab new instruction from Program Memory
            ir_q    <= instr;        // latch full instruction
            alu_op  <= instr[7:5];   // bits 7-5 → ALU
            in_port <= instr[3:0];   // bits 3-0 → Mux
        end

        // if load=0 and rst=0: hold everything frozen during execute phase

    end

endmodule