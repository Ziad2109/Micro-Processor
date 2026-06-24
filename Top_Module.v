module Top_module (
    input  wire       clk,
    input  wire       reset,

    // Debug/FPGA outputs
    output wire [7:0] pc_out,
    output wire [7:0] instruction_out,
    output wire [3:0] accumulator_out,
    output wire [3:0] memory_data_out,
    output wire       zero_flag,
    output wire       carry_flag
);

    // PC and instruction signals
    wire [7:0] pc_address;
    wire [7:0] instruction;

    // Instruction register outputs
    wire [2:0] opcode;
    wire [2:0] ir_alu_bits;
    wire [3:0] memory_address;

    // Control signals
    wire [2:0] alu_select;
    wire       mux_select;
    wire       memory_read;
    wire       memory_write;
    wire       accumulator_write;

    // Datapath signals
    wire [3:0] ram_data;
    wire [3:0] alu_result;
    wire [3:0] accumulator_input;
    wire [3:0] accumulator_data;

    // Prevent execution of the reset value stored in the IR
    reg instruction_valid;

    always @(posedge clk or posedge reset) begin
        if (reset)
            instruction_valid <= 1'b0;
        else
            instruction_valid <= 1'b1;
    end

    PC pc_inst (
        .i_address (4'b0000),
        .i_clk     (clk),
        .i_rst_n   (~reset),
        .i_jump    (1'b0),
        .o_address (pc_address)
    );

    ROM rom_inst (
        .i_addr     (pc_address),
        .o_data_out (instruction)
    );

    IR instruction_register_inst (
        .clk   (clk),
        .reset (reset),
        .load  (1'b1),
        .inst  (instruction),
        .CU    (opcode),
        .ALU   (ir_alu_bits),
        .MUX   (memory_address)
    );

    Control_Unit control_unit_inst (
        .opcode  (opcode),
        .z_flag  (zero_flag),
        .c_flag  (carry_flag),
        .ALU_sel (alu_select),
        .mux     (mux_select),
        .memR    (memory_read),
        .memW    (memory_write),
        .accW    (accumulator_write)
    );

    Single_Port_Ram #(
        .WIDTH (4),
        .DEPTH (16),
        .AW    (4)
    ) data_memory_inst (
        .clk_in        (clk),
        .Read_Or_write (~(memory_write & instruction_valid)),
        .addr          (memory_address),
        .Data_In       (accumulator_data),
        .Data_Out      (ram_data)
    );

    ALU alu_inst (
        .data_mem (ram_data),
        .acc      (accumulator_data),
        .opcode   (alu_select),
        .results  (alu_result),
        .Z        (zero_flag),
        .C        (carry_flag)
    );

    MUX2to1 accumulator_mux_inst (
        .A   (alu_result),
        .B   (ram_data),
        .sel (mux_select),
        .Y   (accumulator_input)
    );
ACC accumulator_inst (
    .clk (clk),
    .rst (~reset),
    .D   (
        (accumulator_write & instruction_valid)
            ? accumulator_input
            : accumulator_data
    ),
    .Q   (accumulator_data)
);

    // External/debug outputs
    assign pc_out          = pc_address;
    assign instruction_out = instruction;
    assign accumulator_out = accumulator_data;
    assign memory_data_out = ram_data;

endmodule
