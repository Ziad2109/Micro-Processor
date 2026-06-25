module ACC(
  input clk,
  input rst,
  input we,           // accW from Control Unit: update ACC and flags only on a write cycle
  input [3:0] D,      // data from the ACC write mux
  input Z_in,         // Z flag from ALU
  input C_in,         // C flag from ALU
  output reg [3:0] Q, // accumulator value
  output reg Z,       // latched Z flag -> Control Unit
  output reg C        // latched C flag -> Control Unit
);
  always @(posedge clk or posedge rst)
    begin
      if (rst) begin
        Q <= 4'b0000;
        Z <= 1'b0;
        C <= 1'b0;
      end
      else if (we) begin
        Q <= D;
        Z <= Z_in;
        C <= C_in;
      end
    end
endmodule
