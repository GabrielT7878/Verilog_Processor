`include "decodificador.v"
module unidade_controle
(
in, 
resetn,
cont,
reg_select,
r_select,
immediate_select,
r0_enable, 
r1_enable,
r2_enable,
r3_enable,
r4_enable,
r5_enable,
r6_enable,
r7_enable,
a_enable,
r_enable,
opSelect,
clear,
negativo
);

input [8:0] in;
input [1:0] cont;
input resetn;
output reg immediate_select;
output reg [7:0] reg_select
output reg r0_enable, r1_enable, r2_enable, r3_enable, r4_enable, r5_enable, r6_enable, r7_enable, a_enable, r_enable, clear;
output reg opSelect, negativo;
reg [2:0] opcode;
reg [2:0] register1, register2;
reg [1:0] status;
reg saida, negar;
wire [7:0] outRegister1, outRegister2, outEnableRegister;

decodificador d1(register1, outRegister1);
decodificador d2(register2, outRegister2);
decodificador d3(register1, outEnableRegister);


always @(posedge resetn) begin
	if(resetn == 1)
		clear <= 1;
	else 
		clear <= 0;
end

always @(in or cont) begin
	opcode = {in[8], in[7], in[6]};
	register1 = {in[5], in[4], in[3]};
	register2 = {in[2], in[1], in[0]};
	clear <= 0;
	case (cont)
			2'b00:begin// clk 1
				//clear = 0;
				r_select <= 0;
				r0_enable <= 0;
				r1_enable <= 0;
				r2_enable <= 0;
				r3_enable <= 0;
				r4_enable <= 0;
				r5_enable <= 0;
				r6_enable <= 0;
				r7_enable <= 0;
				if(opcode == 3'b111) begin
						opSelect <= 1; //REP
						status <= 2'b01;
						negar <= 0;
						saida <= 0;
				end
				else if(opcode == 3'b101) begin
						opSelect <= 1; //LDI
						status <= 2'b11;
						negar <= 0;
						saida <= 0;
				end
				else if(opcode == 3'b000) begin
					opSelect <= 1;// Somar
					status <= 2'b00;
					negar <= 0;
					saida <= 0;
				end 
				else if(opcode == 3'b001) begin
						opSelect <= 1;// Subtrair
						status <= 2'b00;
						negar <= 1;
						saida <= 0;
				end
				else if(opcode == 3'b010) begin
						opSelect <= 0; //NAN
						status <= 2'b00;
						negar <= 0;
						saida <= 0;  
				end
				else if(opcode == 3'b100) begin
						opSelect <= 1; //OUT
						status <= 2'b01;
						negar <= 0;
						saida <= 1;
				end
				
			end
			2'b01:begin// clk 2
				a_enable <= 1;
				if(status == 2'b00 || status == 2'b10 && saida == 1) begin
					immediate_select <= 0;
					r_select <= 0;
					r0_select <= outRegister1;
					r1_select <= outRegister1;
					r2_select <= outRegister1;
					r3_select <= outRegister1;
					r4_select <= outRegister1;
					r5_select <= outRegister1;
					r6_select <= outRegister1;
					r7_select <= outRegister1;
				end else if(status == 2'b01 || 2'b11) begin
					immediate_select <= 0;
					r_select <= 0;
					r0_select <= 0;
					r1_select <= 0;
					r2_select <= 0;
					r3_select <= 0;
					r4_select <= 0;
					r5_select <= 0;
					r6_select <= 0;
					r7_select <= 0;
				end
			end
			2'b10:begin// clk 3
				a_enable <= 0;
				r_enable <= 1;
				if(status != 2'b11) begin
					immediate_select <= 0;
					r_select <= 0;
					r0_select <= outRegister2;
					r1_select <= outRegister2;
					r2_select <= outRegister2;
					r3_select <= outRegister2;
					r4_select <= outRegister2;
					r5_select <= outRegister2;
					r6_select <= outRegister2;
					r7_select <= outRegister2;
				end 
				else begin
					immediate_select <= 1;
					r_select <= 0;
				end

				if(negar == 1)begin
					negativo <= 1;
				end
			end
			2'b11:begin// clk 4
				negativo <= 0;
				r_enable <= 0;
				immediate_select <= 0;
				r_select <= 1;
				status = 2'bxx;
				r0_enable = outEnableRegister[7];
				r1_enable = outEnableRegister[6];
				r2_enable = outEnableRegister[5];
				r3_enable = outEnableRegister[4];
				r4_enable = outEnableRegister[3];
				r5_enable = outEnableRegister[2];
				r6_enable = outEnableRegister[1];
				r7_enable = outEnableRegister[0];
			end
		endcase
end
endmodule