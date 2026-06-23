module ACC(
  input clk,
  input rst,
  input [3:0] D,
  output reg [3:0] Q
);
  always @(posedge clk or negedge rst)
    begin
      if (rst) Q<= 4'b0000;
      else Q <= D;
    end
endmodule
