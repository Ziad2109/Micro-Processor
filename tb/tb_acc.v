`timescale 1ns/1ps
// Testbench: acc  -  Owner: __________
module tb_acc;
    reg        clk = 0, rst = 1, acc_load = 0;
    reg  [3:0] d = 0;
    reg        z_in = 0, c_in = 0;
    wire [3:0] acc_q;
    wire       z_q, c_q;

    acc u_acc (.clk(clk), .rst(rst), .acc_load(acc_load), .d(d),
               .z_in(z_in), .c_in(c_in), .acc_q(acc_q), .z_q(z_q), .c_q(c_q));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_acc.vcd"); $dumpvars(0, tb_acc);
        #12 rst = 0;
        // TODO: load a value with acc_load=1, check acc_q + flags; check hold when acc_load=0.
        #100 $finish;
    end
endmodule
