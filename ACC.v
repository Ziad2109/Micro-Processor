module ACC(
  input clk,
  input rst_n,
  input wire we,        
  input [3:0] D,
  output reg [3:0] Q
);
  always @(posedge clk or negedge rst_n)
    begin
      if (!rst_n) 
        Q <= 4'b0000;
      else if (we) 
        Q <= D;
      
    end
endmodule
