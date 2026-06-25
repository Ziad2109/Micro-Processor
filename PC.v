module PC(
    input wire clk,
    input wire rst,
    input wire [7:0] PC_next,
    output wire [7:0] PC
);

reg [7:0] PCreg ;

always @(posedge clk or posedge rst)
begin

    if (rst) begin
        PCreg <= 0;
    end
    else begin
        PCreg <= PC_next;
    end
end

assign PC = PCreg;

endmodule 