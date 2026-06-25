module Single_Port_Ram #
(
    parameter WIDTH = 4,
    parameter DEPTH = 16,
    parameter AW    = $clog2(DEPTH)
    
)

(
   input  wire               clk_in,
   input  wire               we,         // write enable (Control Unit memW); reads are continuous, gated by memR downstream
   input  wire               in_sel,     // write-data source: 0 = ACC (Data_In), 1 = Input Port
   input  wire [AW - 1: 0]   addr,       // address from ACC
   input  wire [WIDTH - 1: 0] Data_In,   // write data from ACC
   input  wire [WIDTH - 1: 0] in_port,   // 4-bit external Input Port
   output wire [WIDTH - 1:0]  Data_Out,  // read data to ALU
   output wire [WIDTH - 1:0]  out_port   // 4-bit external Output Port (exposes addressed location)
);

reg [WIDTH-1:0] mem [0:DEPTH-1];


always @(posedge clk_in)
begin
    if (we) begin
        mem[addr] <= in_sel ? in_port : Data_In;
    end
end

assign Data_Out = mem[addr];
assign out_port = mem[addr];

endmodule