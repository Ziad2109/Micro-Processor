module Control_Unit (
    input      [3:0]  opcode,
    input             z_flag,
    input             c_flag,  

    output reg [2:0]  ALU_sel,
    output reg        mux,
    output reg        memR,
    output reg        memW,
    output reg        accW,
    output reg        pc_load    // PC branch/jump load (taken branch)

);
  
    localparam ADD   = 4'b0000;
    localparam SUB   = 4'b0001;
    localparam OR    = 4'b0010;
    localparam AND   = 4'b0011;
    localparam LOAD  = 4'b0100;
    localparam STORE = 4'b0101;
    localparam NOP   = 4'b0110;
    localparam JMP   = 4'b0111;
    localparam JZ    = 4'b1000;
    localparam JNZ   = 4'b1001;
    localparam JC    = 4'b1010;
    localparam JNC   = 4'b1011;
  
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
        pc_load = 1'b0;

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

            JMP: begin
                pc_load = 1'b1;        // unconditional jump
            end

            JZ: begin
                pc_load = z_flag;      // jump if zero
            end

            JNZ: begin
                pc_load = ~z_flag;     // jump if not zero
            end

            JC: begin
                pc_load = c_flag;      // jump if carry
            end

            JNC: begin
                pc_load = ~c_flag;     // jump if no carry
            end

            default: begin

            end
        endcase
    end
endmodule
