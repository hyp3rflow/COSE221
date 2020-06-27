module cla_gen(P, G, C0, C);
parameter W = 4;

input [W-1: 0] P, G;
output [W: 0] C;
input C0;

assign C[0] = C0;

genvar i;
generate
    for (i=1; i<=W; i=i+1)
    begin: cla
        assign C[i] = G[i-1] | (P[i-1] & C[i-1]);
    end
endgenerate

endmodule

module addsub_cla(A, B, S, C, M, V);
parameter W = 4;

input [W-1: 0] A, B;
output [W-1: 0] S;
output C, V;
input M;

wire [W-1: 0] p, g;
wire [W: 0] c;
cla_gen #(.W(W)) CLAGEN(.P(p), .G(g), .C0(M), .C(c));

assign V = c[W] ^ c[W-1];
assign C = c[W];

assign p[W-1: 0] = A[W-1:0] ^ (B[W-1:0] ^ {W{M}});
assign g[W-1: 0] = A[W-1:0] & (B[W-1:0] ^ {W{M}});
assign S[W-1: 0] = p[W-1:0] ^ c[W-1:0];

endmodule