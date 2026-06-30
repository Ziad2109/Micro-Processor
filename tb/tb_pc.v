`timescale 1ns/1ps
// Testbench: pc  -  Owner: __________
module tb_pc;
    reg        clk = 0, rst = 1, pc_load = 0;
    reg  [7:0] pc_jump_addr = 8'b0;
    wire [7:0] pc_q;

    pc u_pc (.clk(clk), .rst(rst), .pc_load(pc_load),
             .pc_jump_addr(pc_jump_addr), .pc_q(pc_q));

    always #5 clk = ~clk;          // 100 MHz

	 task automatic  check;
	   input [7:0] expected;
		 input [63:0] test_num;
		 begin 
		 @(posedge clk) #1 ;
		 if (pc_q!==expected) begin 
		 $display("Failtime=%0d  test=%0d incoming=%0h exp=%0h", $time, test_num, pc_q, expected);
		 $finish;
		 end 
		 else 
		 $display (" Pass time=%0d  test=%0d incoming=%0h exp=%0h", $time, test_num, pc_q, expected);
		 end
		 endtask
		  
	  
	 
			initial begin
        $dumpfile("tb_pc.vcd"); $dumpvars(0, tb_pc);
        // TODO: check pc_q counts 0,1,2,... each clock; check reset.
		 
		   check(8'h00,0);
			$display("Pass reset hold");
			@(negedge clk); rst = 0;

		/* normal count */
        check(8'h01, 1);   
        check(8'h02, 2);
        check(8'h03, 3);
        check(8'h04, 4);
        check(8'h05, 5);
		  
		  
		  /*  address jump */
		  @(negedge clk) ;
		  pc_load = 1; 	
		  pc_jump_addr = 8'h0D;
		  
			check(8'h0D,6);
			/*  force reset */
			
			 @(negedge clk);
			 pc_load = 1;
		    pc_jump_addr = 8'h0D;
			 rst =1;
		  
			 check(8'h00,99);
				
		  /* jump  address  then  incremnet  to wrap  around */
		  
		  @(negedge clk);
			rst =0;
		   pc_load = 1;
		   pc_jump_addr = 8'hFD;
			check(8'hFD,7);
		 
		  @(negedge clk); 
			pc_load = 0;

        check(8'hFE, 8);
        check(8'hFF, 9);
        check(8'h00, 10);  //  wrap around
        check(8'h01, 11);
		  
		  
		  
		  $display("tests passed");
		  
		  
		  
		   
		  
		  
        #100 $finish;
    end
endmodule
