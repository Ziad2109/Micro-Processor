module ALU #(
    parameter width = 3,
    parameter depth = 8
)(
    input wire [depth - 1:0] data_in,
    input wire [depth - 1:0] data_acc,
    input wire [width - 1:0] opcode,
    output reg [depth - 1:0] data_out,
    output wire z_flag,
    output reg c_flag
);

    always @(*) begin
        c_flag = 1'b0;
        case (opcode)
            3'b000 : {c_flag, data_out} = data_in + data_acc;
            3'b001 : {c_flag, data_out} = data_in - data_acc;
            3'b010 : data_out = data_in | data_acc;
            3'b011 : data_out = data_in & data_acc;
            3'b100 : data_out = data_in ^ data_acc;
            3'b101 : data_out = ~data_in;
            3'b110 : data_out = data_in << 1;
            3'b111 : data_out = data_in >> 1;
            default: data_out = data_in;
        endcase
    end

    assign z_flag = (data_out == 0);

endmodule
