`timescale 1ns/1ps
// Testbench: data_mem  -  Owner: __________
module tb_data_mem;
    reg        clk = 0, rst = 1, mem_write = 0;
    reg  [3:0] addr = 0, wdata = 0, in_port = 4'h9;
    wire [3:0] rdata, out_port;

    data_mem u_dmem (.clk(clk), .rst(rst), .addr(addr), .mem_write(mem_write),
                     .wdata(wdata), .in_port(in_port),
                     .rdata(rdata), .out_port(out_port));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_data_mem.vcd"); $dumpvars(0, tb_data_mem);
        #12 rst = 0;
        // TODO: write/read back a cell; read INPUT_ADDR(0xE)->in_port;
        //       write OUTPUT_ADDR(0xF)->out_port updates.
        #100 $finish;
    end
endmodule
