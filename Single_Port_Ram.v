module Single_Port_RAM #(
    parameter width = 8,
    parameter depth = 256,
    parameter AW    = $clog2(depth)
)(
    input wire clk,
    input wire Read,
    input wire Write,
    input wire [AW - 1: 0] addr,
    input wire [width - 1: 0] data_in,     
    output wire [depth - 1:0] data_out 
);

    reg [width-1:0] mem [0:depth-1];

    always @(posedge clk) begin             
        if (Write) begin
            mem[addr] <= data_in;           
        end
        if (Read) begin
            data_out <= mem[addr];
        end
    end 


endmodule
