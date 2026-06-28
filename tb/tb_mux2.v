`timescale 1ns/1ps
// Testbench: mux2  -  Owner: __________
module tb_mux2;
    reg  [3:0] in0 = 4'hA, in1 = 4'h5;
    reg        sel = 0;
    wire [3:0] y;

    mux2 u_mux (.in0(in0), .in1(in1), .sel(sel), .y(y));

    initial begin
        $dumpfile("tb_mux2.vcd"); $dumpvars(0, tb_mux2);
        sel = 0; #5 if (y !== in0) $error("sel=0 -> y should be in0");
        sel = 1; #5 if (y !== in1) $error("sel=1 -> y should be in1");
        #10 $display("mux2 ok"); $finish;
    end
endmodule
