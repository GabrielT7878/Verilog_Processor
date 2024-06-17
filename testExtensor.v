`include "extensor.vl"

module testeExtensor;

reg [15:0] in;
wire [15:0] out;

initial $dumpfile("testExtensor.vcd");
initial $dumpvars(0, testeExtensor);
extensor e(in, out);

initial begin
	# 0 in = 16'b0000000001111111;
	# 8 $finish;
end
endmodule