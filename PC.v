module PC(
input wire 		[3:0] i_address, //Unused at the moment
input wire 		i_clk,
input wire 		i_rst_n,
input wire      i_jump, //Unused 
output wire 	[7:0] o_address
);

reg [7:0] temp;
always @(posedge i_clk or negedge i_rst_n)
begin 
        if (!i_rst_n)
            begin 
                temp <=  0;
            end
        else if(i_jump)
            begin 
                //To be added 
            end 
        else 
            begin 
                temp <= temp + 1;
            end
end
assign o_address = temp; 


endmodule 