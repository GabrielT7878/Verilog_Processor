`include "sinal.v"
`include "registrador.v"
`include "ula.vl"
`include "extensor.vl"
`include "contador.v"
`include "mux.vl"
`include "unidade_controle.v"

module processador(clk, iin, resetn, outProcessador);
input clk, resetn;
input [15:0] iin;
output reg [15:0] outProcessador;

// extensor de sinal
wire [15:0] imediat;

// contador
wire [1:0] cont;

//unidade de controle
reg [8:0] iin9;
wire immediate_select;
wire [7:0] reg_select;
wire r0_enable, r1_enable, r2_enable, r3_enable, r4_enable, r5_enable, r6_enable, r7_enable, a_enable, r_enable;
wire opSelect, clear, negativo;

//multiplexador
wire [15:0] bus1, bus;

//ula
wire [15:0] out;

//registrador
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r, a;


always @(bus) begin 
	outProcessador <= bus1;
end

always @(iin)begin
	iin9 <= {iin[15], iin[14],iin[13], iin[12], iin[11], iin[10],iin[9], iin[8], iin[7]};
end

sinal c2(bus1, negativo, bus);

extensor ext (iin, imediat);

contador contad(clk, clear, cont);

unidade_controle uc(
iin9, 
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

mult m(
	imediat, 
	r0,
	r1,
	r2,
	r3,
	r4,
	r5,
	r6,
	r7,
	r,
	immediate_select, 
	reg_select,
	r_select,
	bus1);

ula u(a, bus, opSelect, out);
register Rr0(bus,r0_enable, clk, r0);
register Rr1(bus,r1_enable, clk, r1);
register Rr2(bus,r2_enable, clk, r2);
register Rr3(bus,r3_enable, clk, r3);
register Rr4(bus,r4_enable, clk, r4);
register Rr5(bus,r5_enable, clk, r5);
register Rr6(bus,r6_enable, clk, r6);
register Rr7(bus,r7_enable, clk, r7);
register Rr(out,r_enable, clk, r);
register Ra(bus,a_enable, clk, a);

endmodule