// ============================================================
//  data_mem.v  -  Data Memory  (16x4 RAM + memory-mapped I/O)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________   (meaty block - strong dev)
// ============================================================
module data_mem #(
    parameter INPUT_ADDR  = 4'hE,      // read here returns in_port
    parameter OUTPUT_ADDR = 4'hF       // write here drives out_port
)(
    input  wire        clk,
    input  wire        rst,            // resets out_port only
    input  wire [3:0]  addr,
    input  wire        mem_write,
    input  wire [3:0]  wdata,          // acc.acc_q
    input  wire [3:0]  in_port,
    output wire [3:0]  rdata,          // comb read -> alu.a
    output reg  [3:0]  out_port
);

    // TODO (owner):
    //   reg [3:0] mem [0:15];
    //   assign rdata = (addr == INPUT_ADDR) ? in_port : mem[addr];
    //   always @(posedge clk) begin
    //     if (mem_write) mem[addr] <= wdata;
    //     if (rst) out_port <= 4'b0;
    //     else if (mem_write && addr == OUTPUT_ADDR) out_port <= wdata;
    //   end

endmodule
