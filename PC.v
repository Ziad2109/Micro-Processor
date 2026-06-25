module PC (
    input wire [7:0] i_address,      
    input wire clk,
    input wire rst_n,
    input wire i_jump,                
    output wire [7:0] o_address
);

    reg [7:0] temp;

    always @(posedge clk or negedge rst_n) begin 
        if (!rst_n) begin 
            temp <= 8'd0;
        end else if (i_jump) begin 
            temp <= i_address;        
        end else begin 
            temp <= temp + 1'b1;      
        end
    end

    assign o_address = temp; 

endmodule
