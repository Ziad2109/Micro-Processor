module Single_Port_Ram #
(
    parameter WIDTH = 4,
    parameter DEPTH = 16,
    parameter AW    = $clog2(DEPTH)
    
)

(
   input wire clk_in,
   input wire Read_Or_write,
   input wire [AW - 1: 0] addr,
   input [WIDTH - 1: 0] Data_In,
   output wire [WIDTH - 1:0] Data_Out   
);

reg [WIDTH-1:0] mem [0:DEPTH-1];


always @(posedge clk_in) 
begin
    if (!Read_Or_write) begin

        mem[addr] <= Data_In;

    end
end 

assign Data_Out = mem[addr];

endmodule