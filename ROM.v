module ROM ( 
    input wire [7:0] addr,
    output wire [7:0] data_out
);

    reg [7:0] mem [0:255];
    /*initial begin
        $readmemb("rom_data.txt", mem); 
    end*/
    
    assign data_out = mem[addr];

endmodule
