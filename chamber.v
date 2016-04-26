module chamber(clk, rst, fill, empty, status);
	input clk, rst, fill, empty; 
	output status;
	// 1 = full, 0 = empty

	reg set7, set8; 
	wire done7, done8; 

	parameter empt = 2'b00, fing = 2'b01, full = 2'b10, eing = 2'b11; 
	reg [1:0] ps, ns; 
	assign status = ps[1]; 

	//7 sec to fill, 8 sec to empty 
	t7 timer7(clk, set7, done7);
	t8 timer8(clk, set8, done8);

	always @(posedge clk or posedge rst) begin 
		if (rst) ps <= empt; 
		else ps <= ns; 
	end 

	always @(*)
		case(ps)
			empt: if(fill) begin 
				ns = fing; 
				set7 = 0; 
				set8 = 1;
			end else begin 
				ns = ps; 
				set7 = 1; 
				set8 = 1;
			end 
			fing: if(done7) begin 
				ns = full; 
				set7 = 1;
				set8 = 1;
			end else begin 
				ns = ps; 
				set7 = 0; 
				set8 = 1;
			end 	
			full: if(empty) begin 
				ns = eing; 
				set7 = 1;
				set8 = 0; 
			end else begin
				ns = ps; 
				set7 = 1;
				set8 = 1;
			end 
			eing: if(done8) begin
				ns = empt; 
				set7 = 1; 
				set8 = 1;
			end else begin
				ns = eing;
				set7 = 1; 
				set8 = 0;  
			end 
			default: begin 
				ns = empt; 
				set7 =1;
				set8 =1; 
			end 
		endcase 
endmodule 



module chamber_testbench; 
	wire status; 
	reg clk, rst, fill, empty; 

	chamber test(clk, rst, fill, empty, status);

	always begin 
		#1 clk = ~clk;
	end 

	initial
		begin 
			$dumpfile("chamber.vcd");
			$dumpvars(0, test); //you have to name the module after itself
			clk = 1;
			rst = 0; #10;
			rst = 1; #10;
			rst = 0; #10;
			fill = 1; #5; 
			fill = 0; #25;
			empty = 1; #5; 
			empty = 0; #25; 
			$finish;
		end 
endmodule 