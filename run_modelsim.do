# run_modelsim.do - compile, load, and view the microprocessor testbench in ModelSim
# Launch with:  vsim -do run_modelsim.do   (from this folder, or it cd's itself)

cd {C:/Users/amr19/OneDrive/Desktop/FPGA_WORKSPACE/HDLs/Micro-Processor}

# Fresh work library
vlib work
vmap work work

# Compile RTL + testbench
vlog Top_Module_tb.v Top_Module.v ClockDivider.v SevenSegDecoder.v PC.v ROM.v IR.v Control_Unit.v ALU.v MUX2to1.v ACC.v Single_Port_Ram.v

# Load the testbench: keep GUI open at $finish, preserve signal visibility
vsim -onfinish stop -voptargs="+acc" work.Top_Module_tb

# ---------------- Wave window ----------------
add wave -divider "Testbench"
add wave            sim:/Top_Module_tb/clk
add wave            sim:/Top_Module_tb/dut/cpu_clk
add wave            sim:/Top_Module_tb/rst
add wave -radix hex sim:/Top_Module_tb/input_io
add wave -radix hex sim:/Top_Module_tb/output_io

add wave -divider "Fetch"
add wave -radix hex sim:/Top_Module_tb/dut/PC_Address
add wave -radix hex sim:/Top_Module_tb/dut/IR_Memory

add wave -divider "Decode / Datapath"
add wave -radix hex sim:/Top_Module_tb/dut/opcode
add wave -radix hex sim:/Top_Module_tb/dut/alu_op
add wave -radix hex sim:/Top_Module_tb/dut/imm
add wave -radix hex sim:/Top_Module_tb/dut/acc_q
add wave -radix hex sim:/Top_Module_tb/dut/alu_result
add wave -radix hex sim:/Top_Module_tb/dut/dmem_out

add wave -divider "Flags / Control"
add wave            sim:/Top_Module_tb/dut/z_flag
add wave            sim:/Top_Module_tb/dut/c_flag
add wave            sim:/Top_Module_tb/dut/memW
add wave            sim:/Top_Module_tb/dut/accW
add wave            sim:/Top_Module_tb/dut/pc_load

add wave -divider "Seven-seg (active-low)"
add wave -radix bin sim:/Top_Module_tb/HEX0
add wave -radix bin sim:/Top_Module_tb/HEX1
add wave -radix bin sim:/Top_Module_tb/HEX2
add wave -radix bin sim:/Top_Module_tb/HEX3
add wave -radix bin sim:/Top_Module_tb/HEX4
add wave -radix bin sim:/Top_Module_tb/HEX5

# Run to completion and fit the view
run -all
wave zoom full
