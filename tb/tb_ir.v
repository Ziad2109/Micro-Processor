`timescale 1ns/1ps
// Testbench: ir  -  Owner: __________
module tb_ir;
    reg        clk = 0, rst = 1;
    reg  [7:0] instr = 8'h00;
    wire [7:0] ir_q;

    ir u_ir (.clk(clk), .rst(rst), .instr(instr), .ir_q(ir_q));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_ir.vcd"); $dumpvars(0, tb_ir);
        #12 rst = 0;
        // TODO: drive instr, check ir_q latches it one clock later; check reset.
        #100 $finish;
    end
endmodule
