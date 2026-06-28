// ============================================================
//  accumulator_cpu.v  -  TOP LEVEL  (already wired - do not change ports)
//  8-Bit Accumulator Processor - CND Internship
//
//  Instruction word: { opcode[3:0], addr[3:0] }
//    opcode = ir_q[7:4]   alu_op = ir_q[6:4]   addr = ir_q[3:0]
// ============================================================
module accumulator_cpu (
    input  wire        clk,
    input  wire        rst,
    input  wire [3:0]  in_port,
    output wire [3:0]  out_port
);

    wire [7:0] pc_q, instr, ir_q;
    wire [3:0] dmem_rdata, acc_q, alu_y, mux_y;
    wire       alu_z, alu_c, acc_z, acc_c;
    wire       acc_load, mem_write, mux_sel, pc_load;

    wire [3:0] opcode = ir_q[7:4];
    wire [2:0] alu_op = ir_q[6:4];
    wire [3:0] addr   = ir_q[3:0];

    pc u_pc   
    (
    .clk(), 
    .rst(),
    .pc_load(),                     
    .pc_jump_addr(8'b0),
    .pc_q()
    );

    prog_mem u_pmem 
    (
    .addr(), 
    .instr()
    );

    ir u_ir
    (
    .clk(), 
    .rst(), 
    .instr(), 
    .ir_q()
    );

    control_unit u_cu 
    (
    .opcode(), 
    .z_flag(), 
    .c_flag(),
    .acc_load(),
    .mem_write(),
    .mux_sel(),
    .pc_load()
    );

    alu u_alu  
    (
    .a(), 
    .b(), 
    .alu_op(),
    .y(), 
    .z_flag(), 
    .c_flag()
    );

    mux2 u_mux 
    (
    .in0(),
    .in1(), 
    .sel(), 
    .y()
    );

    acc u_acc  
    (
    .clk(), 
    .rst(), 
    .acc_load(), 
    .d(),                    
    .z_in(), 
    .c_in(),
    .acc_q(), 
    .z_q(), 
    .c_q()
    );

    data_mem  u_dmem 
    (
    .clk(),
    .rst(), 
    .addr(), 
    .mem_write(),
    .wdata(), 
    .in_port(),
    .rdata(), 
    .out_port()
    );

endmodule
