module PC(
input wire 		[3:0] i_address, //Unused at the moment
input wire 		i_clk,
input wire 		i_rst_n,
input wire      i_jump, //Unused 
output wire 	o_address
);

always @(posedge i_clk or negedge i_rst_n)

begin 
        if (!i_rst_n)
            begin 
                o_address <=  0;
            end
        else if(i_jump)
            begin 
                //To be added 
            end 
        else 
            begin 
                o_address <= o_address + 1;
            end
end