module t8(clk, set8, out); 
	input clk, set8; 
	output out; 
	reg tDone; 
	assign out = tDone; 
	
	reg[31:0] count; 

	always@(posedge clk) 
		if(set8) begin 
			count <= 0;
			tDone <= 0; 
		end 
		//else if(count == 32'b0010111110101111000010000000000) begin 
		else if(count == 4'b1000) begin 
			tDone <= 1;
		end
		else begin 
			count <= count + 1'b1; 
		end 
endmodule 

module t8_testbench; 
	reg clk, set8; 
	wire out;

	t8 test(clk, set8, out);

	always begin 
		#1 clk = ~clk;
	end 

	initial
		begin 
			$dumpfile("t7.vcd");
			$dumpvars(0, test); //you have to name the module after itself
			clk = 1;
			set8 = 1; #10;
			set8 = 0; #500000000; 
			$finish;
		end 
endmodule 