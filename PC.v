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
                //This is usually not inisde the PC which should already recieve the jumed address 
            end 
        else 
            begin 
                temp <= temp + 1; // A PC usually does not do this on its own it is often connected to an adder that does this
            end
end
assign o_address = temp; 


endmodule 