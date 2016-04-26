module t7(clk, set7, out); 
	input clk, set7; 
	output out; 
	assign out = tDone; 
	reg tDone; 
	//reg check; 
	//assign check = (timeCheck == count);

	reg[31:0] count; 

	always@(posedge clk) 
		if(set7) begin 
			count <= 1'b0;
			tDone <= 0; 
		end 
		//else if(count == 32'b0010100110111001001001110000000) begin 
		else if(count == 3'b111) begin 
			tDone <= 1;
		end
		else begin 
			count <= count + 1'b1; 
		end 
endmodule 

module t7_testbench; 
	reg clk, set7; 
	wire out;

	t7 test(clk, set7, out);

	always begin 
		#1 clk = ~clk;
	end 

	initial
		begin 
			$dumpfile("t7.vcd");
			$dumpvars(0, test); //you have to name the module after itself
			clk = 1;
			set7 = 1; #10;
			set7 = 0; #500000000; 
			$finish;
		end 
endmodule 