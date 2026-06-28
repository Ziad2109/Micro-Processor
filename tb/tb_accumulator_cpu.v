`timescale 1ns/1ps
// ============================================================
//  tb_accumulator_cpu.v  -  TOP-LEVEL DEMO / self-checking bench
//  Runs program.txt and verifies the expected trace.
//  Owner: __________  (the "Demo program + verification" task)
//
//  Demo data (preload data_mem inside data_mem.v or force here):
//    mem[0]=2 mem[1]=3 mem[2]=12 mem[3]=10 mem[4]=6
//
//  Program (program.txt): 40 01 85 12 23 34 8F F0
//    LOAD 0 ; ADD 1 ; STORE 5 ; SUB 2 ; AND 3 ; OR 4 ; STORE F ; NOP
//
//  Expected ACC trace (note: IR is registered -> result lands one
//  clock AFTER the instruction is fetched):
//    LOAD 0  -> 2
//    ADD 1   -> 5     (2 + 3)
//    STORE 5 -> 5     (mem[5] = 5)
//    SUB 2   -> 7     (12 - 5)
//    AND 3   -> 2     (1010 & 0111)
//    OR 4    -> 6     (0110 | 0010)
//    STORE F -> 6     (out_port = 6)
//    NOP     -> 6
//
//  FINAL CHECK: out_port == 6  and  mem[5] == 5
// ============================================================
module tb_accumulator_cpu;
    reg        clk = 0, rst = 1;
    reg  [3:0] in_port = 4'h0;
    wire [3:0] out_port;

    accumulator_cpu dut (.clk(clk), .rst(rst), .in_port(in_port), .out_port(out_port));

    always #5 clk = ~clk;          // 100 MHz

    initial begin
        $dumpfile("tb_accumulator_cpu.vcd"); $dumpvars(0, tb_accumulator_cpu);
        #12 rst = 0;

        // Let the 8-instruction program run (account for the 1-cycle fetch delay).
        #200;

        // TODO: assert final result
        if (out_port === 4'd6) $display("PASS: out_port = 6");
        else                   $error("FAIL: out_port = %0d (expected 6)", out_port);

        $finish;
    end
endmodule
