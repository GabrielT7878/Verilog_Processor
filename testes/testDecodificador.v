`include "decodificador.v"
module testbench;
reg clock = 0;
reg [2:0] in;
wire [7:0] out;
always #1 clock = !clock;
initial $dumpfile("testDecodificador.vcd");
initial $dumpvars(0, testbench);
decodificador p(in, out);
initial begin
    # 1 in = 3'b000;
    # 2 in = 3'b011;
    # 2 in = 3'b001;
    # 2 in = 3'b111;
    # 8 $finish;
end
endmodule