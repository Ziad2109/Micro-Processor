// ============================================================
//  prog_mem.v  -  Program Memory  (256x8 ROM, combinational read)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________
// ============================================================
module prog_mem (
    input  wire [7:0]  addr,
    output wire [7:0]  instr
);

    // TODO (owner):
    //   reg [7:0] mem [0:255];
    //   initial $readmemh("program.txt", mem);
    //   assign  instr = mem[addr];

endmodule
