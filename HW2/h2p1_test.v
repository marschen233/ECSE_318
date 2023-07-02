//Haowei Chen hxc713

module alu_tb;

wire [15:0] C;
wire overflow;

reg [15:0] A, B;
reg [4:0] alu_code;
reg enable;

alu alu(C, overflow, A, B, alu_code, enable);

initial begin
	$display("ALU Testbench Initiated");
	$dumpfile("alu.vcd");
	$dumpvars;
	$display("\ttime, \tA, \tB, \talu_code, \tC");
	$monitor("%d, \t%h, \t%h, \t%b, \t%h", $time, A, B, alu_code, C);
	enable  = 1'b0;
end
	
initial begin
  enable = 1'b1;
  #5
	alu_code = 5'b00000;
		A = 16'h0000;
		B = 16'h0001;
		#5
		A = 16'h000F;
		B = 16'h000F;
		#5
		A = 16'h7F00;
		B = 16'h0300;
		#5
		A = 16'hFF00;
		B = 16'h0100;
		#5
		A = 16'h8100;
		B = 16'h8000;
		#5
		
	alu_code = 5'b00010;
		A = 16'h0000;
		B = 16'h0001;
		#5
		A = 16'h000F;
		B = 16'h000F;
		#5
		A = 16'h7F00;
		B = 16'h0300;
		#5
		A = 16'hFF00;
		B = 16'h0100;
		#5
		A = 16'h8100;
		B = 16'h8000;
		#5
		
	alu_code = 5'b00100;
		A = 16'h0000;
		B = 16'h0100;
		#5
		A = 16'h0F00;
		B = 16'h0F00;
		#5
		A = 16'h7FFF;
		B = 16'h0300;
		#5
		A = 16'hFF00;
		B = 16'h0100;
		#5
		A = 16'h8100;
		B = 16'h8000;
		#5
		
	alu_code = 5'b00001;
		A = 16'h0000;
		B = 16'h0001;
		#5
		A = 16'h000F;
		B = 16'h000F;
		#5
		A = 16'h7F00;
		B = 16'h0300;
		#5
		A = 16'hFF00;
		B = 16'h0100;
		#5
		A = 16'h8100;
		B = 16'h8000;
		#5
		
	alu_code = 5'b00011;
		A = 16'h0000;
		B = 16'h0001;
		#5
		A = 16'hFF00;
		B = 16'hFCE0;
		#5
		A = 16'h7F00;
		B = 16'h0300;
		#5
		A = 16'hFF00;
		B = 16'h0100;
		#5
		A = 16'h8100;
		B = 16'h8000;
		#5
		
	alu_code = 5'b00101;
		A = 16'h0000;
		B = 16'h0100;
		#5
		A = 16'h000F;
		B = 16'h000F;
		#5
		A = 16'h7F00;
		B = 16'h0300;
		#5
		A = 16'hFF00;
		B = 16'h0100;
		#5
		A = 16'h8000;
		B = 16'h8000;
		#5
	$finish;
end

endmodule
