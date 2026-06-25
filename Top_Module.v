module Top_Module #(
    parameter DIVISOR = 50000000   // CLOCK_50/(2*DIVISOR) ~= 1 Hz CPU clock on the board
)(
    input  wire [3:0] input_io,    // external Input Port   (e.g. SW[3:0])
    input  wire       clk,         // 50 MHz board clock    (CLOCK_50)
    input  wire       rst,         // active-high reset     (e.g. SW, or ~KEY[0])
    output wire [3:0] output_io,   // external Output Port  (e.g. LEDR[3:0])
    output wire [6:0] HEX0,        // ACC value
    output wire [6:0] HEX1,        // Data-memory output (mem[ACC])
    output wire [6:0] HEX2,        // current opcode
    output wire [6:0] HEX3,        // immediate field (IR[3:0])
    output wire [6:0] HEX4,        // PC[3:0]
    output wire [6:0] HEX5         // PC[7:4]
);

// ---------------- Slow CPU clock for the FPGA ----------------
wire cpu_clk;                      // divided clock that actually runs the processor
ClockDivider #(.DIVISOR(DIVISOR)) clkdiv (
    .clk_in  (clk),
    .rst     (rst),
    .clk_out (cpu_clk)
);

// ---------------- Fetch path ----------------
wire [7:0] PC_Address;   // PC output -> Program Memory address
wire [7:0] PC_Next;      // next address (PC+1 or branch target) -> PC
wire [7:0] IR_Memory;    // 8-bit instruction from Program Memory -> IR

// ---------------- Decoded instruction fields (from IR) ----------------
wire [3:0] opcode;       // IR[7:4] -> Control Unit
wire [2:0] alu_op;       // IR[6:4] -> ALU operation select
wire [3:0] imm;          // IR[3:0] -> immediate (mux B) and branch target lower nibble

// ---------------- Control signals (from Control Unit) ----------------
wire [2:0] alu_sel;      // unused: ALU is driven by IR[6:4] directly, per spec
wire       mux_sel;      // ACC write-mux select (0 = ALU result, 1 = immediate)
wire       memR;         // read strobe (data-memory read is continuous, so unused here)
wire       memW;         // write enable -> Data Memory
wire       accW;         // write enable -> ACC
wire       pc_load;      // taken-branch: load branch target instead of PC+1

// ---------------- Datapath buses ----------------
wire [3:0] alu_result;   // ALU result -> ACC write mux (A)
wire       alu_z;        // ALU zero flag  -> ACC
wire       alu_c;        // ALU carry flag -> ACC
wire       z_flag;       // latched Z (from ACC) -> Control Unit
wire       c_flag;       // latched C (from ACC) -> Control Unit
wire [3:0] acc_data;     // ACC write-mux output -> ACC.D
wire [3:0] acc_q;        // ACC value -> ALU operand B, Data Memory address/data
wire [3:0] dmem_out;     // Data Memory read data -> ALU operand A

// Next-PC: branch target = {upper nibble of PC, IR[3:0]} per spec, else PC+1
assign PC_Next = pc_load ? {PC_Address[7:4], imm} : (PC_Address + 8'd1);


PC pc (
    .clk     (cpu_clk),
    .rst     (rst),
    .PC_next (PC_Next),
    .PC      (PC_Address)
);

ROM #(.WIDTH(8), .DEPTH(256)) program_memory(
    .clk  (cpu_clk),
    .addr (PC_Address),
    .dout (IR_Memory)
);

IR ir(
    .clk   (cpu_clk),
    .reset (rst),
    .load  (1'b1),        // latch every fetch
    .inst  (IR_Memory),
    .CU    (opcode),
    .ALU   (alu_op),
    .MUX   (imm)
);

Control_Unit control_unit(
    .opcode  (opcode),
    .z_flag  (z_flag),
    .c_flag  (c_flag),
    .ALU_sel (alu_sel),
    .mux     (mux_sel),
    .memR    (memR),
    .memW    (memW),
    .accW    (accW),
    .pc_load (pc_load)
);

ALU alu(
    .data_mem (dmem_out),
    .acc      (acc_q),
    .opcode   (alu_op),
    .results  (alu_result),
    .Z        (alu_z),
    .C        (alu_c)
);

MUX2to1 acc_mux(
    .A   (alu_result),
    .B   (imm),
    .sel (mux_sel),
    .Y   (acc_data)
);

ACC acc(
    .clk  (cpu_clk),
    .rst  (rst),
    .we   (accW),
    .D    (acc_data),
    .Z_in (alu_z),
    .C_in (alu_c),
    .Q    (acc_q),
    .Z    (z_flag),
    .C    (c_flag)
);

Single_Port_Ram #(.WIDTH(4), .DEPTH(16)) data_memory(
    .clk_in   (cpu_clk),
    .we       (memW),
    .in_sel   (1'b0),       // write source = ACC (set to 1 to write from Input Port)
    .addr     (acc_q),
    .Data_In  (acc_q),
    .in_port  (input_io),
    .Data_Out (dmem_out),
    .out_port (output_io)
);

// ---------------- Seven-segment displays (DE10-Standard HEX0..HEX5) ----------------
SevenSegDecoder hex0 (.bin(acc_q),           .seg(HEX0));   // ACC (result)
SevenSegDecoder hex1 (.bin(output_io),       .seg(HEX1));   // mem[ACC] output
SevenSegDecoder hex2 (.bin(opcode),          .seg(HEX2));   // opcode
SevenSegDecoder hex3 (.bin(imm),             .seg(HEX3));   // immediate
SevenSegDecoder hex4 (.bin(PC_Address[3:0]), .seg(HEX4));   // PC low nibble
SevenSegDecoder hex5 (.bin(PC_Address[7:4]), .seg(HEX5));   // PC high nibble

endmodule
