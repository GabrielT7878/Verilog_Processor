module sinal(in, controle, out);

input [15:0] in;
input controle;
output reg [15:0] out;

always @(in or controle) begin
	if(controle)
		out <= - in;
	else
		out <= in;
end

endmodule