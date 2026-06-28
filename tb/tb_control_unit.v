`timescale 1ns/1ps
// Testbench: control_unit  -  Owner: __________
module tb_control_unit;
    reg  [3:0] opcode = 4'h0;
    reg        z_flag = 0, c_flag = 0;
    wire       acc_load, mem_write, mux_sel, pc_load;

    control_unit u_cu (.opcode(opcode), .z_flag(z_flag), .c_flag(c_flag),
                       .acc_load(acc_load), .mem_write(mem_write),
                       .mux_sel(mux_sel), .pc_load(pc_load));

    initial begin
        $dumpfile("tb_control_unit.vcd"); $dumpvars(0, tb_control_unit);
        // TODO: sweep all opcodes, assert strobes:
        //   ADD/SUB/AND/OR/LOAD -> acc_load=1 ; STORE -> mem_write=1 ; NOP -> all 0.
        #100 $finish;
    end
endmodule
