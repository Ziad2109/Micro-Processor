module ACC(
  input clk, // Master clock signal
  input rst_n, // Active low asynchronous signal
  input wire we, // Write/enable control signal, active high
  input [3:0] D, // 4 bit data input, coming from the data out of ALU
  output reg [3:0] Q // Sent to the ALU, known as data_acc in the ALU code
);
  always @(posedge clk or negedge rst_n)
    begin
      if (!rst_n) 
        Q <= 4'b0000;
      else if (we) 
        Q <= D; // Load new data D into the register if we is active high.
      
    end
endmodule
