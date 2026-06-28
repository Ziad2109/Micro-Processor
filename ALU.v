module ALU #(
    parameter width = 3, // Bit width of opcode
    parameter depth = 8 // Bit width for data input and output
)(
    input wire [depth - 1:0] data_in, // Data Input
    input wire [depth - 1:0] data_acc, // Data input coming from the accumulator
    input wire [width - 1:0] opcode, // Operation code used to select the operation   
    output reg [depth - 1:0] data_out, // Data output that will be sent to the multiplexer
    output wire z_flag, // High if data out is equal to zero
    output reg c_flag // High if there is an overflow or underflow
);

    always @(*) begin
        c_flag = 1'b0; // Default assignment to prevent any latch generation
        case (opcode)
            3'b000 : {c_flag, data_out} = data_in + data_acc; // Addition with carryout
            3'b001 : {c_flag, data_out} = data_in - data_acc; // Subtraction with borrow out
            3'b010 : data_out = data_in | data_acc; // Bitwise OR
            3'b011 : data_out = data_in & data_acc; //Bitwise AND
            3'b100 : data_out = data_in ^ data_acc; // Bitwise XOR
            3'b101 : data_out = ~data_in; // Bitwise NOT
            default: data_out = data_in; // Handles any undefined operation.
        endcase
    end

    assign z_flag = (data_out == 0); // Z_flag becomes 1 if all bits of data out are 0, else becomes 0.

endmodule
