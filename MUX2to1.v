module MUX2to1 (
    input wire [3:0] data_a,    
    input wire [3:0] data_b,    
    input wire sel,
    output wire [3:0] data_out 
);
    assign data_out = sel ? data_b : data_a;

endmodule
