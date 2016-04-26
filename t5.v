module t5(clk, set5, out); 
	input clk, set5; 
	output out; 
	assign out = tDone; 
	reg tDone; 
	//reg check; 
	//assign check = (timeCheck == count);

	reg[31:0] count; 

	always@(posedge clk) 
		if(set5) begin 
			count <= 0;
			tDone <= 0; 
		end 
		//else if(count == 32'b001110111001101011001010000000) begin 
		else if(count == 3'b101) begin 
			tDone <= 1;
		end
		else begin 
			count <= count + 1'b1; 
		end 
endmodule 

module t5_testbench; 
	reg clk, set5; 
	wire out;

	t5 test(clk, set5, out);

	always begin 
		#1 clk = ~clk;
	end 

	initial
		begin 
			$dumpfile("t7.vcd");
			$dumpvars(0, test); //you have to name the module after itself
			clk = 1;
			set5 = 1; #10;
			set5 = 0; #500000000; 
			$finish;
		end 
endmodule 