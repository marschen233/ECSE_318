module Handshake(
	input R,A,RESET,clk,	//Request, Acknowledge, asynchronous RESET
	output E,		//Error
	output [2:0] state
);

	reg e;
	reg [2:0] State;
	localparam [2:0]
		S0 = 3'b000,
		S1 = 3'b001,
		S2 = 3'b010,
		S3 = 3'b011,
		S4 = 3'b100;	//Error State

	initial
	begin
		e = 0;
		State = S0;
	end

	always @(posedge clk or RESET)
	begin

		if(RESET)
		begin
			State = S0;
			e= 0;
		end
		else
		case(State)
			S0:
			begin
			if(R && ~A)
				State = S1;
			else if(A)
			begin
                                State = S4;
                                e = 1;
                        end

			end

			S1:
			begin
			if(R && A)
				State = S2;
			else if(~R && ~A)
			begin
                                State = S4;
                                e = 1;
                        end

			end

			S2:
			begin
			if(~R && A)
				State = S3;
			if(R && ~A)
			begin
                                State = S4;
                                e = 1;
                        end

			end

			S3:
			begin
			if(~R && ~A)
				State = S0;
			else if(R && A)
			begin
				State = S4;
				e = 1;
			end
			end

			S4:
			begin
			//remain here until RESET
			end
		endcase
	end

	assign E = e;
	assign state = State;
endmodule

//Test module for handshake
module testHandshake();
	reg R,A,clk,RESET;
	wire E;
	wire [2:0] state;

	initial
	begin
	$monitor("R = %b \t A = %b \t Reset = %b \t E = %b \t state = %h \t clock = %b", R, A, RESET, E, state, clk);
	R = 0;	A = 0;	RESET = 0;
	clk = 0;

	#3 R = 1;

	#10 A = 1;

	#10 R = 0;
	
	#10 A = 0;

	#10 A = 1;

	#10  R = 1;

	#14 RESET = 1;

	#5 $finish();
	end

	always
		#5 clk = ~clk;

	Handshake h (R,A,RESET,clk,E,state);
endmodule
