`include "registrador.v"
module testbench;
reg clock = 0;
reg [15:0] in;
reg enable = 0;
wire [15:0] out;
always #1 clock = !clock;
initial $dumpfile("testRegistrador.vcd");
initial $dumpvars(0, testbench);
register p(in, enable, clock, out);
initial begin
    # 1 enable = 1'b1;
    # 1 in = 16'b0000000000000011;
    # 2 enable = 1'b0;
    # 1 in = 16'b0000000000000111;
    # 2 enable = 1'b1;
    # 8 $finish;
end
endmodule