module ROM #(
    parameter        WIDTH     = 8,
    parameter        DEPTH     = 256,
    parameter        AW        = $clog2(DEPTH),
    parameter        INIT_FILE = "rom_init.txt"
)(
    input                  clk,
    input      [AW-1:0]    addr,
    output reg [WIDTH-1:0] dout
);

    reg [WIDTH-1:0] mem [0:DEPTH-1];

    initial begin
        $readmemh(INIT_FILE, mem);
    end

    always @(posedge clk) begin
        dout <= mem[addr];
    end

endmodule