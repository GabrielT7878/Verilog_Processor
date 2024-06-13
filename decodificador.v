module decodificador(in, out);
input [2:0] in;
output [7:0] out;
reg [7:0] out;

always @(in) begin
    out = 8'b00000000;
    out[7 - in] = 1'b1; 
end
endmodule
