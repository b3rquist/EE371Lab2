module 7seg (rst, in, out);	
	input rst; 
	input [3:0] in; 
	output [6:0] out;   

	always @(*) begin 
		case(in) 
			4'b0000:
			4'b0001:
			4'b0010:
			4'b0011:
			4'b0100:
			4'b0101:
			4'b0110:
			4'b0111:
			4'b1000:
			4'b1111: out = 
			default: out = 7'b0; 
		endcase  
	end 

endmodule 