`timescale 1ns/1ps
// Testbench: control_unit  -  Owner: __________
module tb_control_unit;
    reg  [3:0] opcode = 4'h0;
    reg        z_flag = 0, c_flag = 0;
    wire       acc_load, mem_write, mux_sel, pc_load, memR;
	  

    control_unit u_cu (.opcode(opcode), .z_flag(z_flag), .c_flag(c_flag),
                       .acc_load(acc_load), .mem_write(mem_write),
                       .mux_sel(mux_sel), .pc_load(pc_load),.memR(memR));
							  
							  
		task automatic check;
		  input [3:0] op;
		  input expected ;
			reg check_val;
			begin
			
		 opcode=op;
		  #10; 
			
			
		   case(opcode)
		4'h0, 4'h1, 4'h2, 4'h3, 4'h4: // ADD, SUB, AND, OR, LOAD
                check_val = ((acc_load == expected) && (mem_write == 0)  && (memR == expected));

   4'h5: // STORE
                check_val = ((mem_write == expected) && (acc_load == 0) && (memR == 0));
            default:
                check_val = (acc_load == 0) && (mem_write == 0);
	  endcase 
	if (check_val !== 1'b1) begin
            $display("FAIL Opcode=%0h acc_load=%0b mem_write=%0b exp=%0b time=%0t", opcode, acc_load, mem_write, expected, $time);
            $finish;
        end else begin
            $display("PASS Opcode=%0h acc_load=%0b mem_write=%0b exp=%0b time=%0t", opcode, acc_load, mem_write, expected, $time);
        end
    end
endtask
		
    initial begin
        $dumpfile("tb_control_unit.vcd"); $dumpvars(0, tb_control_unit);
        
    check(4'h0, 1'b1); // ADD
    check(4'h1, 1'b1); // SUB
    check(4'h2, 1'b1); // AND
    check(4'h3, 1'b1); // OR
    check(4'h4, 1'b1); // LOAD
    check(4'h5, 1'b1); // STORE

    $display("ALL TESTS COMPLETED");
    $finish;

		  
    end
endmodule