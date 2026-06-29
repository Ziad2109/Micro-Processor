// ============================================================
//  data_mem.v  -  Data Memory  (16x4 RAM + memory-mapped I/O)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________   (meaty block - strong dev)
// ============================================================
module data_mem #(
    parameter INPUT_ADDR  = 4'hE,
    parameter OUTPUT_ADDR = 4'hF
)(
    input  wire       clk,
    input  wire       rst,
    input  wire [3:0] addr,
    input  wire       mem_write,
    input  wire [3:0] wdata,
    input  wire [3:0] in_port,
    output wire [3:0] rdata,
    output reg  [3:0] out_port
);

    reg [3:0] mem [0:15];
    integer i;

    initial begin
        for (i = 0; i < 16; i = i + 1)
            mem[i] = 4'h0;

        mem[0] = 4'd2;
        mem[1] = 4'd3;
        mem[2] = 4'd12;
        mem[3] = 4'd10;
        mem[4] = 4'd6;
    end

    assign rdata =
        (addr == INPUT_ADDR)  ? in_port  :
        (addr == OUTPUT_ADDR) ? out_port :
                                mem[addr];

    always @(posedge clk) begin
        if (rst) begin
            out_port <= 4'h0;
        end
        else if (mem_write) begin
            if (addr == OUTPUT_ADDR)
                out_port <= wdata;
            else if (addr != INPUT_ADDR)
                mem[addr] <= wdata;
        end
    end

endmodule
