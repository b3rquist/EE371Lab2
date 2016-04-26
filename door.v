module door(clk, reset, open, close, status);
	input clk, reset, open, close; 
	output status; 

	reg state; 
	assign status = state;
	// 0 = open, 1 = closed

	always @(posedge clk or posedge reset)
		begin  
			if(reset || close)
				state = 1; 
			else if(open)
				state = 0; 
		end 
endmodule 


module door_testbench; 
	reg clk, reset, open, close;
	wire status; 

	door test(clk, reset, open, close, status);

	always begin 
		#5 clk = ~clk;
	end 

	initial
		begin 
			$dumpfile("door.vcd");
			$dumpvars(0, test); //you have to name the module after itself
			clk = 1;
			reset = 0; #10;
			reset = 1; #10;
			reset = 0; #10;
	 		open = 1; #10;
			open = 0; #10; 
			close = 1; #10;
			open = 0; #30; 
			$finish;
		end 
endmodule 