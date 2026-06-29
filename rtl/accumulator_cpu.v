// ============================================================
//  accumulator_cpu.v  -  TOP LEVEL  (already wired - do not change ports)
//  8-Bit Accumulator Processor - CND Internship
//
//  Instruction word: { opcode[3:0], addr[3:0] }
//    opcode = ir_q[7:4]   alu_op = ir_q[6:4]   addr = ir_q[3:0]
// ============================================================
module accumulator_cpu (
    input  wire       clk,
    input  wire       rst,
    input  wire [3:0] in_port,
    output wire [3:0] out_port
);

    wire [7:0] pc_q;
    wire [7:0] instr;
    wire [7:0] ir_q;

    wire [3:0] dmem_rdata;
    wire [3:0] acc_q;
    wire [3:0] alu_y;
    wire [3:0] mux_y;

    wire alu_z;
    wire alu_c;
    wire acc_z;
    wire acc_c;

    wire acc_load;
    wire mem_write;
    wire mux_sel;
    wire pc_load;

    wire [3:0] opcode;
    wire [2:0] alu_op;
    wire [3:0] addr;

    assign opcode = ir_q[7:4];
    assign alu_op = ir_q[6:4];
    assign addr = ir_q[3:0];

    pc u_pc (
        .clk(clk),
        .rst(rst),
        .pc_load(pc_load),
        .pc_jump_addr({4'h0, addr}),
        .pc_q(pc_q)
    );

    prog_mem u_pmem (
        .addr(pc_q),
        .instr(instr)
    );

    ir u_ir (
        .clk(clk),
        .rst(rst),
        .instr(instr),
        .ir_q(ir_q)
    );

    control_unit u_cu (
        .opcode(opcode),
        .z_flag(acc_z),
        .c_flag(acc_c),
        .acc_load(acc_load),
        .mem_write(mem_write),
        .mux_sel(mux_sel),
        .pc_load(pc_load)
    );

    alu u_alu (
        .a(dmem_rdata),
        .b(acc_q),
        .alu_op(alu_op),
        .y(alu_y),
        .z_flag(alu_z),
        .c_flag(alu_c)
    );

    mux2 u_mux (
        .in0(alu_y),
        .in1(addr),
        .sel(mux_sel),
        .y(mux_y)
    );

    acc u_acc (
        .clk(clk),
        .rst(rst),
        .acc_load(acc_load),
        .d(mux_y),
        .z_in(alu_z),
        .c_in(alu_c),
        .acc_q(acc_q),
        .z_q(acc_z),
        .c_q(acc_c)
    );

    data_mem u_dmem (
        .clk(clk),
        .rst(rst),
        .addr(addr),
        .mem_write(mem_write),
        .wdata(acc_q),
        .in_port(in_port),
        .rdata(dmem_rdata),
        .out_port(out_port)
    );

endmodule
