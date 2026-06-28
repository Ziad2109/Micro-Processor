`timescale 1ns/1ps
// Testbench: alu  -  Owner: __________
module tb_alu;
    reg  [3:0] a = 0, b = 0;
    reg  [2:0] alu_op = 0;
    wire [3:0] y;
    wire       z_flag, c_flag;

    alu u_alu (.a(a), .b(b), .alu_op(alu_op), .y(y), .z_flag(z_flag), .c_flag(c_flag));

    initial begin
        $dumpfile("tb_alu.vcd"); $dumpvars(0, tb_alu);
        // TODO: test each op (ADD/SUB/AND/OR/PASS_A) + z_flag + c_flag.
        //   e.g. a=4,b=3,ADD -> y=7 ; a=12,b=5,SUB -> y=7 ; a=10,b=7,AND -> y=2.
        #100 $finish;
    end
endmodule
