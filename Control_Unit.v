module Control_Unit (
    input      [2:0]  opcode,
    input             z_flag,
    input             c_flag,  

    output reg [2:0]  ALU_sel,  
    output reg        mux,
    output reg        memR,
    output reg        memW, 
    output reg        accW
    
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
        
        ALU_sel = 3'b000;
        mux     = 1'b0;
        memR    = 1'b0;
        memW    = 1'b0;
        accW    = 1'b0;

        case (opcode)

            NOP: begin
                
            end

            LOAD: begin
                memR    = 1'b1;
                mux     = 1'b1;  
                accW    = 1'b1;  
                ALU_sel = ALU_PASS;
            end

            STORE: begin
                memW = 1'b1;     
            end

            ADD: begin
                memR    = 1'b1;
                mux     = 1'b0;  
                accW    = 1'b1;
                ALU_sel = ALU_ADD;
            end

            SUB: begin
                memR    = 1'b1;
                mux     = 1'b0;
                accW    = 1'b1;
                ALU_sel = ALU_SUB;
            end

            OR: begin
                memR    = 1'b1;
                mux     = 1'b0;
                accW    = 1'b1;
                ALU_sel = ALU_OR;
            end

            AND: begin
                memR    = 1'b1;
                mux     = 1'b0;
                accW    = 1'b1;
                ALU_sel = ALU_AND;
            end

            default: begin
                
            end

        endcase
    end

endmodule
