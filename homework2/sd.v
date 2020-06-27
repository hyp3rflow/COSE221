module addsub_cla(A, B, S, C, M, V)
	input [W-1:0] A;//input a
	input [W-1:0] B;//input b
	output [W-1:0] S;//result
	output C;//carry
	input M;//0->add 1->sub
	output V;//overflow
	reg [W-1:0] P;
	reg [W-1:0] G;
	wire[W:0] w_C;
	
	always @ (A or B or M)
	begin
	if(M)
	begin
	P = A^~B;
	G = A&~B;
	end

	else
	begin
	P = A^B;
	G = A&B;
	end
	
	cla_gen CLAGEN(.P(P), .G(G), .C0(M), .C(w_C));
	
	genvar i;
	for(i=0; i<W; i=i+1)
	begin
	assign S[i]=P[i]^C[i];
	end
	
	assign C=w_C[W];
	assign V=C&(~w_C[W]);
	
	
endmodule	

module cla_gen(P, G, C0, C)
	parameter W=4;
	input [W-1:0] P;//input p
	input [W-1:0] G;//input g
	input C0;
	output [W:0] C;
	
	assign C[0]=C0;
	
	genvar i;
	
	for(i=0; i<W; i=i+1)
	begin
	assign C[i+1]=G[i]|(P[i]&C[i]);
	end
	
endmodule


/*module adder(A, B, OutP, OutG)
	input A;
	input B;
	output OutP;
	output OutG;
	
	assign OutP = A^B;
	assign OutG = A&B;
	
endmodule

module subtract(A, B, OutP, OutG)
	input A;
	input B;
	output OutP;
	output OutG;
	
	assign OutP = A^~B;
	assign OutG = A&~B;
	
endmodule*/