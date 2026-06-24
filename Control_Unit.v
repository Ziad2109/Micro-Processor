module Control_Unit(
    input wire [2:0] opcode,
    output reg [2:0] ALU_set,      
    output reg mux,
    output reg memR,
    output reg memW, 
    output reg accW,
    output reg IR_load,
    output reg PC_branch
);
  
    localparam ADD   = 3'b000; 
    localparam SUB   = 3'b001;
    localparam OR    = 3'b010;
    localparam AND   = 3'b011;
    localparam LOAD  = 3'b100;
    localparam STORE = 3'b101;
    localparam NOP   = 3'b110;
  
    localparam ALU_ADD  = 3'b000;
    localparam ALU_SUB  = 3'b001;
    localparam ALU_OR   = 3'b010;
    localparam ALU_AND  = 3'b011;
    localparam ALU_PASS = 3'b100;
  
    always @(*) begin
        ALU_set   = 3'b000;       
        mux       = 1'b0;
        memR      = 1'b0;
        memW      = 1'b0;
        accW      = 1'b0;
        IR_load   = 1'b0;        
        PC_branch = 1'b0;

        case (opcode)
            NOP: begin
            
            end

            LOAD: begin
                memR    = 1'b1;
                mux     = 1'b1;  
                accW    = 1'b1;  
                ALU_set = ALU_PASS; 
            end

            STORE: begin
                memW    = 1'b1;     
            end

            ADD: begin
                memR    = 1'b1;
                mux     = 1'b0;  
                accW    = 1'b1;
                ALU_set = ALU_ADD; 
            end

            SUB: begin
                memR    = 1'b1;
                mux     = 1'b0;
                accW    = 1'b1;
                ALU_set = ALU_SUB;  
            end

            OR: begin
                memR    = 1'b1;
                mux     = 1'b0;
                accW    = 1'b1;
                ALU_set = ALU_OR;  
            end

            AND: begin
                memR    = 1'b1;
                mux     = 1'b0;
                accW    = 1'b1;
                ALU_set = ALU_AND;  
            end

            default: begin
                
            end
        endcase
    end

endmodule
