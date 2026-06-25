module ALU(
  input [3:0] data_mem,
  input [3:0] acc,
  input [2:0] opcode,
  output reg [3:0] results,
  output Z,
  output C
);
  reg carry;
  always @(*)
    begin
      carry = 0;
      case (opcode)
        3'b000: {carry,results} = data_mem+acc;
        3'b001: {carry,results} = data_mem-acc;
        3'b010: results = data_mem | acc;
        3'b011: results = data_mem & acc;
        default: results = acc;
      endcase
    end
  assign C = carry;
  assign Z = (results == 4'b0000);
endmodule
