`include "ula.vl"

module testeUla;

reg [15:0] in_a, in_b;
reg op_select;
wire [15:0] out;

initial $dumpfile("testUla.vcd");
initial $dumpvars(0, testeUla);
ula u(in_a, in_b, op_select, out);

initial begin
	# 0 op_select = 1'b1;
	# 0 in_a = 16'b0000000000000001;
	# 0 in_b = 16'b0000000000000011;
	# 8 op_select = 1'b0;
	# 0 in_a = 16'b1111111111111111;
	# 0 in_b = 16'b1111111111111111;
	# 8 $finish;
end
endmodule