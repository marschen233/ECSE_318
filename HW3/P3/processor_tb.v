module processor_tb();

reg clock;

processor UUT(.clock(clock));

initial begin
	clock = 1'b0;
end

always begin
	#5 clock <= ~clock;
end

endmodule 
