module Top_Module (
    input  wire       clk,
    input  wire       reset,

    output wire [7:0] pc_out,
    output wire [7:0] instruction_out,
    output wire [3:0] accumulator_out,
    output wire [3:0] memory_data_out,
    output wire       zero_flag,
    output wire       carry_flag
);

    wire [7:0] pc_address;
    wire [7:0] instruction;

    wire [2:0] opcode;
    wire [2:0] ir_alu_bits;
    wire [3:0] memory_address;

    wire [2:0] alu_select;
    wire       mux_select;
    wire       memory_read;
    wire       memory_write;
    wire       accumulator_write;
    wire       IR_load;
    wire       PC_branch;

    wire [3:0] ram_data;
    wire [3:0] alu_result;
    wire [3:0] accumulator_input;
    wire [3:0] accumulator_data;

    reg instruction_valid;

    always @(posedge clk or posedge reset) begin
        if (reset)
            instruction_valid <= 1'b0;
        else
            instruction_valid <= 1'b1;
    end

    //=========================================================
    // Program Counter
    //=========================================================
    PC pc_inst (
        .i_address (4'b0000),
        .clk       (clk),
        .rst_n     (~reset),
        .i_jump    (1'b0),
        .o_address (pc_address)
    );

    //=========================================================
    // ROM
    //=========================================================
    ROM rom_inst (
        .addr     (pc_address),
        .data_out (instruction)
    );

    //=========================================================
    // Instruction Register
    //=========================================================
    IR instruction_register_inst (
        .clk   (clk),
        .rst_n (~reset),
        .load  (1'b1),
        .inst  (instruction),
        .CU    (opcode),
        .MUX   (memory_address)
    );

    //=========================================================
    // Control Unit
    //=========================================================
    Control_Unit control_unit_inst (
        .opcode    (opcode),
        .ALU_set   (alu_select),
        .mux       (mux_select),
        .memR      (memory_read),
        .memW      (memory_write),
        .accW      (accumulator_write),
        .IR_load   (IR_load),
        .PC_branch (PC_branch)
    );

    //=========================================================
    // RAM
    //=========================================================
    Single_Port_RAM data_memory_inst (
        .clk           (clk),
        .Read_Or_Write (~(memory_write & instruction_valid)),
        .addr          (memory_address),
        .data_in       (accumulator_data),
        .data_out      (ram_data)
    );

    //=========================================================
    // ALU
    //=========================================================
    ALU alu_inst (
        .data_in  (ram_data),
        .data_acc (accumulator_data),
        .opcode   (alu_select),
        .data_out (alu_result),
        .z_flag   (zero_flag),
        .c_flag   (carry_flag)
    );

    //=========================================================
    // MUX
    //=========================================================
    MUX2to1 accumulator_mux_inst (
        .data_a   (alu_result),
        .data_b   (ram_data),
        .sel      (mux_select),
        .data_out (accumulator_input)
    );

    //=========================================================
    // Accumulator
    //=========================================================
    ACC accumulator_inst (
        .clk      (clk),
        .rst_n    (~reset),
        .we (accumulator_write),
        .D  (accumulator_input),
        .Q (accumulator_data)
    );

    //=========================================================
    // Debug Outputs
    //=========================================================
    assign pc_out          = pc_address;
    assign instruction_out = instruction;
    assign accumulator_out = accumulator_data;
    assign memory_data_out = ram_data;

endmodule
