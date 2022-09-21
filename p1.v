// Haowei Chen
module P1(
	input [3:0] X,
	input [3:0] Y,
	output [7:0] P
);

	wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11;
	wire d1,d2,d3,d4,d5,d6,d7;
	wire e1,e2,e3;
	wire f1,f2,f3,f4,f5,f6,f7;
	wire g1,g2,g3,g4;

	and(c1,X[3],Y[1]),
 	   (c2,X[2],Y[2]),
	   (c3,X[1],Y[3]),
	   (c4,X[3],Y[0]),
	   (c5,X[2],Y[1]),
	   (c6,X[1],Y[2]),
	   (c7,X[2],Y[0]),
	   (c8,X[1],Y[1]),
	   (c9,X[0],Y[2]),
	   (c10,X[1],Y[0]),
	   (c11,X[0],Y[1]),
	   (P[0],X[0],Y[0]);

	FA fa1(c1,c2,c3,d2,d1);
	FA fa2(c4,c5,c6,d4,d3);
	FA fa3(c7,c8,c9,d6,d5);
	FA fa4(c10,c11,1'b0,P[1],d7);

	and(e1,X[2],Y[3]),
	   (e2,X[3],Y[2]),
	   (e3,X[0],Y[3]);

	FA fa5(e1,e2,d1,f2,f1);
	FA fa6(d2,d3,f5,f4,f3);
	FA fa7(d4,e3,d5,f6,f5);
	FA fa8(d6,d7,1'b0,P[2],f7);

	and(g1,X[3],Y[3]);

	FA fa9(g1,f1,g2,P[6],P[7]);
	FA fa10(f2,f3,g3,P[5],g2);
	FA fa11(f4,1'b0,g4,P[4],g3);
	FA fa12(f6,f7,1'b0,P[3],g4);

endmodule

//test bench module
module Test_P1; 
	reg [3:0] A,B;
	wire [7:0] P;
	
	initial
	begin
	$monitor("A = %b \t B = %b \t Product = %b",A,B,P);
	A = 4'b0010;	B = 4'b0100;

	#20
	A = 4'b1111;	B = 4'b0011;
	end

	P1 M1(A, B, P);
endmodule

//full adder module
module FA (A, B, cin, sum, cout);
	input A,B,cin;
	output sum,cout;
	
	assign sum = A^B^cin;
	assign cout = (A&B)|(A&cin)|(B&cin);
endmodule

