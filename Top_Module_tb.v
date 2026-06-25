`timescale 1ns/1ps

module Top_Module_tb;

    // ---------------- DUT I/O ----------------
    reg  [3:0] input_io;
    reg        clk;
    reg        rst;
    wire [3:0] output_io;
    wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

    // ---------------- Device under test ----------------
    // DIVISOR=2 keeps the divider legal (>=2) while letting the CPU step
    // every 4 tb-clocks, so the program runs quickly in simulation.
    Top_Module #(.DIVISOR(2)) dut (
        .input_io  (input_io),
        .clk       (clk),
        .rst       (rst),
        .output_io (output_io),
        .HEX0      (HEX0),
        .HEX1      (HEX1),
        .HEX2      (HEX2),
        .HEX3      (HEX3),
        .HEX4      (HEX4),
        .HEX5      (HEX5)
    );

    // ---------------- Board clock: 10 ns period ----------------
    initial clk = 1'b0;
    always #5 clk = ~clk;

    // ---------------- Waveform dump (VCD) ----------------
    initial begin
        $dumpfile("Top_Module_tb.vcd");
        $dumpvars(0, Top_Module_tb);   // dump TB + full DUT hierarchy (incl. cpu_clk, HEX*)
    end

    // ---------------- Stimulus ----------------
    initial begin
        input_io = 4'h0;
        rst      = 1'b1;                       // assert reset (active high)
        repeat (4) @(posedge clk);
        @(negedge clk) rst = 1'b0;             // release reset

        repeat (60) @(posedge dut.cpu_clk);    // run 60 CPU steps

        $display("\nSimulation complete at %0t ns", $time);
        $finish;
    end

    // ---------------- Console trace: one line per CPU clock ----------------
    initial begin
        $display("");
        $display("  time | PC  instr | op acc Z C | memW accW pcld | out | HEX0(acc)");
        $display("-------+-----------+-----------+----------------+-----+----------");
        forever begin
            @(posedge dut.cpu_clk);
            #1;  // sample after registered values settle
            $display(" %5t | %h   %h  | %h  %h  %b %b |  %b    %b    %b   |  %h  | %b",
                     $time, dut.PC_Address, dut.IR_Memory, dut.opcode,
                     dut.acc_q, dut.z_flag, dut.c_flag,
                     dut.memW, dut.accW, dut.pc_load, output_io, HEX0);
        end
    end

endmodule
