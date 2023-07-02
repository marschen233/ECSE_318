//Haowei Chen hxc713

module alu(actualC, actualOverflow, a, b, alu_code, enable);

output reg [15:0] actualC;
output reg actualOverflow;

input [15:0] a,b;
input [4:0] alu_code;
input enable;

wire [15:0] arithmeticC, logicC, shiftC, setC;
wire arithmeticOverflow, logicOverflow, shiftOverflow, setOverflow;

arithmetic arithmetic(arithmeticC, arithmeticOverflow, a, b, alu_code, enable);
logic logic(logicC, logicOverflow, a, b, alu_code, enable);
shift shift(shiftC, shiftOverflow, a, b, alu_code, enable);
set set(setC, setOverflow, a, b, alu_code, enable);

always @(enable) begin
	if (alu_code[4:3] == 2'b00)
	begin
		actualC = arithmeticC;
		actualOverflow = arithmeticOverflow;
	end

	else if (alu_code[4:3] == 2'b01)
	begin
		actualC = logicC;
		actualOverflow = logicOverflow;
	end

	else if (alu_code[4:3] == 2'b10)
	begin
		actualC = shiftC;
		actualOverflow = shiftOverflow;
	end

	else if (alu_code[4:3] == 2'b11)
	begin
		actualC = setC;
		actualOverflow = setOverflow;
	end
end

endmodule

module arithmetic(actualC, overflow, a, b, alu_code, enable);

output reg [15:0] actualC;
output reg overflow;

input [15:0] a,b;
input [4:0] alu_code;
input enable;

reg signed [16:0] signedC;
reg unsigned [16:0] unsignedC;
wire signed [15:0] signedA, signedB;

assign signedA = a;
assign signedB = b;

initial
	overflow = 1'b0;

always @(enable) begin
	
	//add	
	if (alu_code[2:0] == 3'b000)
	begin
		signedC = signedA + signedB;
		actualC = signedC[15:0] ;
		
		if (signedC > 32767 || signedC < -32768)
			overflow = 1'b1;
	end

	//addu
	if (alu_code[2:0] == 3'b001)
	begin
		unsignedC = a + b;
		actualC = unsignedC[15:0];
		
		if (unsignedC[16] == 1'b1)
			overflow = 1'b1;
	end
	
	//sub
	if (alu_code[2:0] == 3'b010)
	begin
		signedC = signedA - signedB;
		actualC = signedC[15:0];
		
		if (signedC > 32767 || signedC < -32768)
			overflow = 1'b1;
	end
	
	//subu
	if (alu_code[2:0] == 3'b011)
	begin
		unsignedC = a - b;
		actualC = unsignedC[15:0];
		
		if (unsignedC[16] == 1'b1)
			overflow = 1'b1;
	end
	
	//inc
	if (alu_code[2:0] == 3'b100)
	begin
		signedC = signedA + 1'b1;
		actualC = signedC[15:0];
		
		if (signedC > 32767 || signedC < -32768)
			overflow = 1'b1;
	end
	
	//dec
	if (alu_code[2:0] == 3'b101)
	begin
		signedC = signedA - 1'b1;
		actualC = signedC[15:0];
		
		if (signedC > 32767 || signedC < -32768)
			overflow = 1'b1;
	end
	
end

endmodule

module logic(c, overflow, a, b, alu_code, enable);

output reg [15:0] c;
output reg overflow;

input [15:0] a,b;
input [4:0] alu_code;
input enable;

initial 
	overflow = 1'b0;

always @(enable) begin

	//and
	if (alu_code[2:0] == 3'b000)
	begin
		c = a && b;
	end

	//or
	if (alu_code[2:0] == 3'b001)
	begin
		c = a || b;
	end
	
	//xor
	if (alu_code[2:0] == 3'b010)
	begin
		c = a ^ b;
	end
	
	//not
	if (alu_code[2:0] == 3'b011)
	begin
		c = ~a;
	end	
end

endmodule

module set(c, overflow, a, b, alu_code, enable);

output reg [15:0] c;
output reg overflow;

input [15:0] a,b;
input [4:0] alu_code;
input enable;

initial
begin
	overflow = 1'b0;
	c = 16'b0000000000000000;
end

always @(enable) begin

	//sle
	if (alu_code[2:0] == 3'b000)
	begin
		if (a <= b)
			c = 16'b0000000000000001;
	end

	//slt
	if (alu_code[2:0] == 3'b001)
	begin
		if (a < b)
			c = 16'b0000000000000001;
	end
	
	//sge
	if (alu_code[2:0] == 3'b010)
	begin
		if (a >= b)
			c = 16'b0000000000000001;
	end
	
	//sgt
	if (alu_code[2:0] == 3'b011)
	begin
		if (a > b)
			c = 16'b0000000000000001;
	end
	
	//seq
	if (alu_code[2:0] == 3'b100)
	begin
		if (a == b)
			c = 16'b0000000000000001;
	end
	
	//sne
	if (alu_code[2:0] == 3'b101)
	begin
		if (a != b)
			c = 16'b0000000000000001;
	end
end

endmodule

module shift(c, overflow, a, b, alu_code, enable);

output reg [15:0] c;
output reg overflow;

input [15:0] a,b;
input [4:0] alu_code;
input enable;

initial
	overflow = 1'b0;

always @(enable) begin
	
	//sll
	if (alu_code[2:0] == 3'b000)
	begin
			c = a << b[3:0];
	end

	//srl
	if (alu_code[2:0] == 3'b001)
	begin
		c = a >> b[3:0];
	end
	
	//sla
	if (alu_code[2:0] == 3'b010)
	begin
		c = a <<< b[3:0];
	end
	
	//sra
	if (alu_code[2:0] == 3'b011)
	begin
		c = a <<< b[3:0];
	end
end

endmodule


