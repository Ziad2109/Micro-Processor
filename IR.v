module IR (
    input  wire        clk, 
    input  wire        reset,
    input  wire        load,
    input  wire [7:0]  inst,
 
    output reg  [3:0]  CU,    
    output reg  [2:0]  ALU,   
    output reg  [3:0]  MUX    
);

    always @(posedge clk or posedge reset)
    begin 
        if (reset)         
        begin 
            CU  <= 4'b0000;
            ALU <= 3'b000;
            MUX <= 4'b0000;
        end
        else if (load)     
        begin 
            CU  <= inst[7:4];
            ALU <= inst[6:4];
            MUX <= inst[3:0];
        end  
        
    end 

endmodule
