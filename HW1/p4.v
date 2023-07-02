//Carry Save Adder module to add 10 8-bit
module P4(
	input [7:0] a,b,c,d,e,f,g,h,i,j,
	input cin,
	output [15:0] z,
	output cout
);
	wire [8:0] s1, c1;
	wire [9:0] s2, c2;
	wire [10:0] s3, c3;
	wire [11:0] s4, c4;
	wire [12:0] s5, c5;
	wire [13:0] s6, c6;
	wire [14:0] s7, c7;
	wire [15:0] s8, c8;

	//first CSA (8-bit)
	N_bit #(8) N1(a, b, c, s1, c1);

	//second CSA (9-bit)
	N_bit #(9) N2(c1, s1, {1'b0,d}, s2, c2);

	//third CSA (10-bit)
	N_bit #(10) N3(c2, s2, {2'b00,e}, s3, c3);

	//fourth CSA (11-bit)
 	N_bit #(11) N4(c3, s3, {3'b000,f}, s4, c4);

	//fifth CSA (12-bit)
	N_bit #(12) N5(c4, s4, {4'b0000,g}, s5, c5);

	//sixth CSA (13-bit)
	N_bit #(13) N6(c5, s5, {5'b00000,h}, s6, c6);

	//seventh CSA (14-bit)
	N_bit #(14) N7(c6, s6, {6'b000000,i}, s7, c7);

	//eigth CSA (15-bit)
	N_bit #(15) N8(c7, s7, {7'b0000000,j}, s8, c8);

	//final adder
	NAdder #16 n(s8, c8, cin, z, cout);
endmodule

//Test bench module for CSA
module Test_P4();
	reg [7:0] A,B,C,D,E,F,G,H,I,J;
	wire [15:0] P;
	wire Co;

	initial
	begin
	//1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	A = 8'h01;	B = 8'h02;	C = 8'h03;	D = 8'h04;
	E = 8'h05;	F = 8'h06;	G = 8'h07;	H = 8'h08;
	I = 8'h09;	J = 8'h0A;

	//3, 4, 5, 6, 7, 8, 9, 10
	#18 $display("%b" , P);
	#2
	A = 8'h03;	B = 8'h04;	C = 8'h05;	D = 8'h06;
	E = 8'h07;	F = 8'h08;	G = 8'h09;	H = 8'h0A;
	I = 8'h00;	J = 8'h00;
	
	#20 $display("%b" , P);
	#2 $finish();
	end

	P4 c1(A, B, C, D, E, F, G, H, I, J, 1'b0, P, Co);
endmodule

//n-bit CSA module
module N_bit(A, B, C, sum, cout);
	parameter N = 18;
	input [N-1:0] A,B,C;
	output[N:0] sum, cout;
	
	genvar i;
	generate for(i=0; i<N; i=i+1)
	begin
		FA f(A[i], B[i], C[i], sum[i], cout[i+1]);
	end
	endgenerate

	assign cout[0] = 1'b0;

endmodule

//n-bit adder module
module NAdder(a, b, cin, z, cout);
	parameter N=16;
	input [N-1:0] a,b;
	input cin;
   	output [N-1:0] z;
   	output  cout;
  	wire [N-1:0] carry;

  	genvar i;
   	generate for(i=0;i<N;i=i+1)
        begin
   	   if(i==0) 
  		FA f(a[i],b[i],cin,z[i],carry[i]);
  	   else
  		FA f(a[i],b[i],carry[i-1],z[i],carry[i]);
     	end

  	assign cout = carry[N-1];
   	endgenerate
endmodule 

//full adder module
module FA(A, B, cin, sum, cout);
	input A,B,cin;
	output sum,cout;
	
	assign sum = A^B^cin;
	assign cout = (A&B)|(A&cin)|(B&cin);
endmodule		
