// ============================================================
//  alu.v  -  Arithmetic Logic Unit  (4-bit, combinational)
//  8-Bit Accumulator Processor - CND Internship
//  Owner: __________   (meaty block - strong dev)
// ============================================================
module alu (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire [2:0] alu_op,
    output reg  [3:0] y,
    output reg        z_flag,
    output reg        c_flag
);

    reg [4:0] temp;

    always @* begin
        y = 4'h0;
        c_flag = 1'b0;
        temp = 5'h00;

        case (alu_op)
            3'b000: begin // ADD: a + accumulator
                temp = {1'b0, a} + {1'b0, b};
                y = temp[3:0];
                c_flag = temp[4];
            end

            3'b001: begin // SUB: memory - accumulator
                y = a - b;
                c_flag = (a < b); // 1 means a borrow occurred
            end

            3'b010: begin // AND
                y = a & b;
            end

            3'b011: begin // OR
                y = a | b;
            end

            3'b100: begin // PASS_A, used by LOAD
                y = a;
            end

            default: begin
                y = b; // harmless hold-like value for unused operations
            end
        endcase

        z_flag = (y == 4'h0);
    end

endmodule
