`timescale	10ns/100ps

module Traffic_Light(LightA, LightB, clk, reset);
input clk, reset;

/* Since FSM is using behavior level so we need to declare the variable as reg */
reg [3:0] ccount, ncount; 						//Current Count & Next Count
reg [2:0] cs, ns; 								//Current State & Next State
output reg [2:0] LightA, LightB;



//Next State Combinational Logic
always@(*)begin
	case(cs)
	
	3'b000:
	begin
		ncount = (ccount < 4'd10) ? ccount + 4'd1 : 4'd1;
		ns = (ccount < 4'd10) ? 3'b000 : 3'b001;
	end
	
	3'b001:
	begin
		ncount = (ccount < 4'd3) ? ccount + 4'd1 : 4'd1;
		ns = (ccount < 4'd3) ? 3'b001 : 3'b010;		
	end
	
	3'b010:
	begin
		ncount = (ccount < 4'd5) ? ccount + 4'd1 : 4'd1;
		ns = (ccount < 4'd5) ? 3'b010 : 3'b011;
	end
	
	3'b011:
	begin
		ncount = (ccount < 4'd15) ? ccount + 4'd1 : 4'd1;
		ns = (ccount < 4'd15) ? 3'b011 : 3'b100;
	end
	
	3'b100:
	begin
		ncount = (ccount < 4'd3) ? ccount + 4'd1 : 4'd1;
		ns = (ccount < 4'd3) ? 3'b100 : 3'b101;
	end
	
	3'b101:
	begin
		ncount = (ccount < 4'd5) ? ccount + 4'd1 : 4'd1;
		ns = (ccount < 4'd5) ? 3'b101 : 3'b000;
	end
	endcase
end

//State Register
always@(posedge clk or negedge reset)begin
	if(!reset)
	begin
		ccount <= 4'd1;
		cs <= 3'b000;
	end
	else
	begin
		ccount <= ncount;
		cs <= ns;
	end
end

//Output Combinational Logic
always@(*)begin
	case(cs)
	
	3'b000:
	begin
		LightA = 3'b001;
		LightB = 3'b100;
	end
	
	3'b001:
	begin
		LightA = 3'b010;
		LightB = 3'b100;
	end
	
	3'b010:
	begin
		LightA = 3'b100;
		LightB = 3'b100;
	end
	
	3'b011:
	begin
		LightA = 3'b100;
		LightB = 3'b001;
	end
	
	3'b100:
	begin
		LightA = 3'b100;
		LightB = 3'b001;
	end
	
	3'b101:
	begin
		LightA = 3'b100;
		LightB = 3'b100;
	end
	endcase
end

endmodule