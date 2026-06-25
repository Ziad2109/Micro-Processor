module Single_Port_RAM #(
    parameter width = 8,
    parameter depth = 256,
    parameter AW    = $clog2(depth)
)(
    input wire clk,
    input wire Read_Or_Write,
    input wire [AW - 1: 0] addr,
    input wire [width - 1: 0] data_in,     
    output wire [width - 1:0] data_out 
);

    reg [width-1:0] mem [0:depth-1];

    always @(posedge clk) begin             
        if (Read_Or_Write) begin
            mem[addr] <= data_in;           
        end
		end
		
  assign data_out = mem[addr];

endmodule
