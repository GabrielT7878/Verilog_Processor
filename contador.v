module contador(clock, clear, out);

input clear, clock;
output [1:0] out;
reg [1:0] out = 0;

always @(negedge clock) begin
	if(!clear) 
        out = out + 1'b1;
	else out  = 2'b00;
end

endmodule