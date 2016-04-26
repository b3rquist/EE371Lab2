module control(clk, rst, appr, dprt, DO, DI, fill, empty, LEDR4, LEDR3, LEDR2, LEDR1, LEDR0);
	input clk, rst, 
	reg [1:0] state;
	
/*	LEDR4 = Bathospehre inside chamber 
	LEDR2 = DO (1 = closed, 0 = open) = door outter 
	
*/
	//create paramaters for the states of the chamber 
	parameter BCnH = 2'b00, BCH = 2b'01, OOH = 2'b10, IOnH = 2'b11; 

	//create resigsters for our present and next states
	reg [1:0] ps, ns;

	//registers to keep track of where the doors are and whats in the chamber 
	reg H, iD, oD;  

	//assign the LEDRs to their status indicators 
	assign LEDR3 = iD;
	assign LEDR2 = oD; 

	//registers that control door opening and closing, limited to chamebr status  
	reg outerDoor, innerDoor; 
	assign outerDoor = DO & H; 
	assign innerDoor = DI & ~H; 

	//connect t5 to SW0 and LEDR0
	t5 timer5(.clk, .set5(~SW0), .out(LEDR0)); 



	//instantiate our sub state machines 
	door outer(.clk, .rst, .open(outerDoor), .close(~outerDoor), .status(oD));
	door inner(.clk, .rst, .open(innerDoor), .close(~innerDoor), .status(iD));
	chamber c1(.clk, .rst, .fill, .empty, .status(H));
endmodule 

module control_testbench();



endmodule 

/*

	//flip flop block 
	always @(posedge clk)
		if(rst) begin 
			ps <= BCnH;
		end else begin 
			ps <= ns; 
		end 

	always @(*)
		case(ps)
			BCnH: if(DI & ~H) begin 
				ns = IOnH;
			end else if(H & iD & oD) begin  
				ns = BCH;
			end else begin 
				ns = ps; 
			end 
			BCH: if(~H & iD & oD) begin 
				ns = BCnH; 
			end  else if(H & ~oD & iD) begin 
				ns = OOH; 
			end else begin 
				ns = ps; 
			end 
			OOH: if(H & ~oD & iD) begin 
				ns = BCH; 
			end else begin 
				ns = ps; 
			end 
			IOnH: if(~H & ~iD & oD) begin 
				ns = BCnH; 
			end else begin 
				ns = ps; 
			end 
			default: ns = ps; 
		endcase

*/