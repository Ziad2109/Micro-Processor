module Control_Unit(
    input wire [2:0] opcode,        //instruction OP Code recived from IR
    output reg [2:0] ALU_set,       //instruction ALU Code delievered to ALU
    output reg mux,                 //instruction 1'b delivered to MUX
    output reg memR,                //istruction 1'b delievred to Data Memory to Read
    output reg memW,                //instruction 1'b delievred to Data Memory to Write 
    output reg accW,                //instruction 1'b delievred to Accumlator
    output reg IR_load,            
    output reg PC_branch         
);

   // ==============================================================================
    // Instruction OP Code Definition 
   // ==============================================================================
  
    localparam ADD   = 3'b000; 
    localparam SUB   = 3'b001;
    localparam OR    = 3'b010;
    localparam AND   = 3'b011;
    localparam LOAD  = 3'b100;
    localparam STORE = 3'b101;
    localparam NOP   = 3'b110;

    // ==============================================================================
    // ALU Operation Select Definition 
   // ==============================================================================
  
    localparam ALU_ADD  = 3'b000;
    localparam ALU_SUB  = 3'b001;
    localparam ALU_OR   = 3'b010;
    localparam ALU_AND  = 3'b011;
    localparam ALU_PASS = 3'b100;
  
    always @(*) begin  

        // default all control signals to inactive
        
        ALU_set   = 3'b000;       
        mux       = 1'b0;
        memR      = 1'b0;
        memW      = 1'b0;
        accW      = 1'b0;
        IR_load   = 1'b0;        
        PC_branch = 1'b0;

        case (opcode)
            NOP: begin

                // all signals remain at default (inactive)
                // processor idles for one cycle
            
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
