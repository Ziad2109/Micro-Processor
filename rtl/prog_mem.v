// ============================================================
//  prog_mem.v  -  Program Memory  (256x8 ROM, combinational read)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________
// ============================================================
module prog_mem (
    input  wire [7:0] addr,
    output wire [7:0] instr
);

    reg [7:0] rom [0:255];

    initial begin
        // Unspecified locations become NOPs.
        integer i;
        for (i = 0; i < 256; i = i + 1)
            rom[i] = 8'hF0;

        $readmemh("program.txt", rom);
    end

    assign instr = rom[addr];

endmodule
