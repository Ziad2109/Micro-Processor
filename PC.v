module PC (    
    input wire clk,
    input wire rst_n,                
    output wire [7:0] o_address //ouput address 
);

    reg [7:0] temp;

    always @(posedge clk or negedge rst_n) begin 
        if (!rst_n) begin //Reset condition 
            temp <= 8'd0;
        end 
              else begin //Default beahviour incriment address by 1
            temp <= temp + 1'b1; 
        end
    end

    assign o_address = temp; //New address is recieved by ouput port 

endmodule
