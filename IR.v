module IR (
    input wire clk, 
    input wire rst_n,
    input wire load,
    input wire [7:0] inst,
 
    output reg [2:0] CU,
    output reg [3:0] MUX
);

    always @(posedge clk or negedge rst_n) begin 
        if (!rst_n) begin 
            CU  <= 3'b000;
            MUX <= 4'b0000;
        end else if (load) begin    // Changed to 'else if' to prevent race conditions
            CU  <= inst[7:5];
            MUX <= inst[4:0];
        end  
    end 
endmodule
