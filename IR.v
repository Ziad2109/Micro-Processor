module IR (
    input wire clk, // Master clock signal
    input wire rst_n, // Active low reset signal
    input wire load, // Instruction load enable (for fetching the instructions)
    input wire [7:0] inst, // 8 bit instruction fetched from the program memory
 
    output reg [2:0] CU, // 3 bit opcode sent to the control unit
    output reg [3:0] MUX // 4 bit operand/address sent to the multiplexer.
);

    always @(posedge clk or negedge rst_n) begin 
        if (!rst_n) begin 
            CU  <= 3'b000;
            MUX <= 4'b0000;
        end else if (load) begin    // Changed to 'else if' to prevent race conditions
            CU  <= inst[7:5]; // Top 3 bits determine the operation type
            MUX <= inst[3:0]; // Bottom 4 bits point to a memory address
        end  
    end 
endmodule

//Hello guys hi 