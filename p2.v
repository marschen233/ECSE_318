//module for an n-bit shift-add multiplier
module P2(clk, A, B, R, start, done);
	parameter M = 4;
	input clk,start;
	input [M-1:0] A, B;
	output [M*2-1:0] R;
	output done;
	
	reg [M-1:0] X, P;
	reg c; // carry out flip-flop
	reg fin;
	wire [M-1:0] w1, w2; 
	wire [M:0] w5;
	wire w3;
	wire [M*2-1:0] w4;
	reg [M:0] i;

	initial
	begin
		c = 1'b0;
		P = 0;
		X = 0;
		fin = 0;
		i = 1'b1;
	end

	always @(posedge start)
	begin
		X = B;
		P = 0;
		i = 1'b1; 
		fin = 0;
	end

	NAnd #(M) n(clk, A, X[0], w1); // AND every bit of A with the LSB of X
	NAdder #(M) ad(clk, w1[M-1:0], P[M-1:0], c, w2[M-1:0], w3); // Add result to P
	NShift #(M*2) sh1(clk, {w2,X}, w3, w4); // Shift P and X registers
	NShiftReg #(M+1) sh2(clk, i, 1'b0, w5);

	always @(negedge clk)
	begin
	if(!fin)
	begin
		X = w4[M-1:0];
		P = w4[M*2-1:M];

		i = w5;
	end

	fin = i[M];
		
	end

	

	assign R = {P[M-1:0],  X[M-1:0]}; // assign output as P register
	assign done = fin;
endmodule

//Test bench module
module Test_P2;
	reg [3:0] A, B;
	reg clk,start; 
	wire [7:0] P;
	wire done;

	initial
	begin
	clk = 1'b0;
	A = 4'b0010;    B = 4'b0100;
	#1 start = 1;
	#6 start = 0;

	#36 $display("%b", P); 
	    start = 1;
	A = 4'b1111;    B = 4'b0011;
	#3 start = 0;
	
	#36 $display("%b", P);
	#4 $finish();
	end

	always
	begin
		#5 clk = !clk;
	end

	P2 #4 m1(clk, A, B, P, start, done);

endmodule

//n-bit adder module
module NAdder(enable, a, b, cin, out, cout);
	parameter N=16;
	input [N-1:0] a,b;
	input enable, cin;
   	output [N-1:0] out;
   	output  cout;
	reg [N-1:0] z, carry;

  	genvar i;
   	generate for(i=0;i<N;i=i+1)
        begin
	always @*
	begin
		if(enable)
		begin
   	   		if(i==0)
			begin
				z[i] = a[i]^b[i]^cin;
				carry[i] = (a[i]&b[i])|(a[i]&cin)|(b[i]&cin);
			end
  	   		else
			begin
				z[i] = a[i]^b[i]^carry[i-1];
				carry[i] = (a[i]&b[i])|(a[i]&carry[i-1])|(b[i]&carry[i-1]);
			end
     		end
	end
	end

	assign out = z;
  	assign cout = carry[N-1];
   	endgenerate
endmodule 

// n-bit and module
// Ands every bit of an n-bit input with a one-bit input
// Assigns the outcome to the output
module NAnd(enable, a, b, out);
	parameter M = 8;
	input [M-1:0] a;
	input enable, b;
	output [M-1:0] out;
	reg [M-1:0] z;

	genvar i;
	generate for(i=0;i<M;i=i+1)
	begin
	always @*
	begin
		if(enable)
		z[i] <= a[i] & b;
	end
	end
	endgenerate

	assign out = z;
endmodule

//n-bit shift register
//shifts an n-bit register left by one bit
module NShift(enable, d, carry, q);
	parameter M = 4;
	input [M-1:0] d;
	input enable, carry;
	output [M-1:0] q;
	reg [M-1:0] z;

	genvar i;
	generate for(i=0;i<M;i=i+1)
	begin
	always @*
	begin
		if(enable)
		begin
			if(i==M-1)
			z[i] = carry;
		
			else
			z[i] = d[i+1];
		end
	end
	end
	endgenerate

	assign q = z;
endmodule

//n-bit shift register
//shifts an n-bit register right by one bit
module NShiftReg(enable, d, carry, q);
	parameter M = 4;
	input [M-1:0] d;
	input enable, carry;
	output [M-1:0] q;
	reg [M-1:0] z;

	genvar i;
	generate for(i=M-1;i>=0;i=i-1)
	begin
	always @*
	begin
		if(enable)
		begin
			if(i==0)
			z[i] = carry;
		
			else
			z[i] = d[i-1];
		end
	end
	end
	endgenerate

	assign q = z;
endmodule
