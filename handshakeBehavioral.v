//Haowei Chen hxc713


module handshakeBehavioral(error, clk, req, ack, reset);


output reg error;

input clk, req, ack, reset;

reg reqPast, ackPast;

initial 
begin
	error = 1'b0;
	reqPast = 1'b0;
	ackPast = 1'b0;
end

always @(posedge clk)
begin
	if (req && ~reqPast && ~ack && ~ackPast && ~error)
		assign reqPast = 1'b1;
	else if (req && reqPast && ack && ~ackPast && ~error)
		assign ackPast = 1'b1;
	else if (~req && reqPast && ack && ackPast && ~error)
		assign reqPast = 1'b0;
	else if (~req && ~reqPast && ~ack && ackPast && ~error)
		assign ackPast = 1'b0;
	else if (req == reqPast && ack == ackPast)
	begin end //Do nothing because the inputs haven't changed
	else if (error)
	begin
		if (reset)
			assign error = 1'b0;
	end
	else
		assign error = 1'b1;
end

endmodule
