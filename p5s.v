//Structural Verilog model of Finite State Machine
module P5Strc (out, E, W, clk);
	input E,W,clk;
	output out;
	wire Q1, Q2, L1, L2, L3, L4, Q1B, Q2B, D1, D2;

		NOT N1(Q2B, Q2);
		NOT N2(Q1B, Q1);

		AND A1(L1, Q1, Q2B);
		AND A2(L2, Q1, W);
		AND A3(L3, Q2, Q1B);
		AND A4(L4, Q2, E);

		NOR R1(out, Q1, Q2);

		OR O1(D1, E, L1, L2);
		OR O2(D2, W, L3, L4);

		DFF F1(Q1, D1, clk);
		DFF F2(Q2, D2, clk);
endmodule

//Test bench module for FSM_Strc
module P5Strc_test;
	reg E, W, Clk;

	P5Strc F1(Out, E, W, Clk);


	initial
	begin
		Clk = 0;
		E = 0;
		W= 0;

		#2 W = 1; //go from State 0 to State 1

		#10 E = 1; //go from State 1 to State 2

		#10 E = 0; //go from State 2 to State 0
			 W = 0;

		#10 E = 1; //go from State 0 to State 3
		
		#10 W = 0; //go from State 3 to State 2
		
		#10 E = 0; //go from State 2 to State 0

		#20 $finish();
	end
	
	always
		#5 Clk = ~Clk;
endmodule

	

//D Flip Flop module
module DFF(Q, D, clk);
	input D, clk;
	output Q;
	reg z;

	initial
	begin
		z=0;
	end

	always @(posedge clk)
		z=D;

	assign Q = z;
endmodule
