`include "processador.v"
module testbench;
reg clock = 0;
reg [15:0] iin;
reg resetn = 1;
wire [15:0] bus;
always #1 clock = !clock;
initial $dumpfile("testProcessador.vcd");
initial $dumpvars(0, testbench);
processador p(clock, iin, resetn, bus);
initial begin
    # 0 resetn = 1'b0;
    # 8 iin = 16'b1010000000000001;
    # 8 iin = 16'b1010010000000010;
    # 8 iin = 16'b1110000010000000;
    # 8 iin = 16'b1000000000000;
    # 8 $finish;
end
endmodule