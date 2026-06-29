// ============================================================
//  pc.v  -  Program Counter  (sequential)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________
// ============================================================
module pc (
    input  wire       clk,
    input  wire       rst,
    input  wire       pc_load,
    input  wire [7:0] pc_jump_addr,
    output reg  [7:0] pc_q
);

    always @(posedge clk) begin
        if (rst)
            pc_q <= 8'h00;
        else if (pc_load)
            pc_q <= pc_jump_addr;
        else
            pc_q <= pc_q + 8'h01;
    end

endmodule
