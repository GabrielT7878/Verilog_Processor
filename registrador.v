module register(in, enable, clk, out);
input [15:0] in;
input enable, clk;
output [15:0] out;
reg [15:0] out;

always @(negedge clk) begin
	if(enable)
		out <= in;
end
endmodule