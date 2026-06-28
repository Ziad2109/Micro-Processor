`timescale 1ns/1ps
// Testbench: prog_mem  -  Owner: __________
// Needs program.txt on the run path (repo root).
module tb_prog_mem;
    reg  [7:0] addr = 0;
    wire [7:0] instr;

    prog_mem u_pmem (.addr(addr), .instr(instr));

    initial begin
        $dumpfile("tb_prog_mem.vcd"); $dumpvars(0, tb_prog_mem);
        // TODO: walk addr 0..7, check instr matches program.txt (40,01,85,12,23,34,8F,F0).
        #100 $finish;
    end
endmodule
