module rom #( 
  
) ( 
    input wire [7:0] i_addr,
    output wire [7:0] o_data_out
);

reg [7:0] mem [0:255];
/*intial
begin
#readmb(,mem);
end */
assign o_data_out = mem[i_addr];

endmodule