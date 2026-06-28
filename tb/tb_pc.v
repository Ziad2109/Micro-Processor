`timescale 1ns/1ps
// Testbench: pc  -  Owner: __________
module tb_pc;
    reg        clk = 0, rst = 1, pc_load = 0;
    reg  [7:0] pc_jump_addr = 8'b0;
    wire [7:0] pc_q;

    pc u_pc (.clk(clk), .rst(rst), .pc_load(pc_load),
             .pc_jump_addr(pc_jump_addr), .pc_q(pc_q));

    always #5 clk = ~clk;          // 100 MHz

    initial begin
        $dumpfile("tb_pc.vcd"); $dumpvars(0, tb_pc);
        #12 rst = 0;
        // TODO: check pc_q counts 0,1,2,... each clock; check reset.
        #100 $finish;
    end
endmodule
