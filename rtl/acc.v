// ============================================================
//  acc.v  -  Accumulator  (4-bit register + flag latch)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________
// ============================================================
module acc (
    input  wire       clk,
    input  wire       rst,
    input  wire       acc_load,
    input  wire [3:0] d,
    input  wire       z_in,
    input  wire       c_in,
    output reg  [3:0] acc_q,
    output reg        z_q,
    output reg        c_q
);

    always @(posedge clk) begin
        if (rst) begin
            acc_q <= 4'h0;
            z_q   <= 1'b1;
            c_q   <= 1'b0;
        end
        else if (acc_load) begin
            acc_q <= d;
            z_q   <= z_in;
            c_q   <= c_in;
        end
    end

endmodule
