module addsub_cla(A,B,S,C,M,V);
    parameter W = 4;
    input [W-1:0] A,B;
    output [W-1:0] S;
    output C;
    input M;
    output V;

    wire [W-1:0] p, g;
    wire [W-1:0] S;
    wire [W:0] c;

    genvar i;
    generate
        for(i=0;i<W;i=i+1)
        begin
            assign g[i] = A[i] & B[i];
            assign p[i] = A[i] ^ B[i];
        end
    endgenerate

    cla_gen CLAGEN( .P(p), .G(g), .C0(M), .C(c));

    for(i=0;i<W;i=i+1)
    begin
        assign S[i] = p[i] ^ c[i];
    end

    assign C = c[W];
    assign V = c[W] ^ c[W-1];

endmodule

module cla_gen(P,G,C0,C);
    parameter W = 4;
    input [W-1:0] P, G;
    input C0;
    output [W:0] C;

    wire [W:0] C;
    genvar i;

    assign C[0] = C0;
    generate
        for(i=0;i<W;i=i+1)
        begin
            assign C[i+1] = G[i] | ( P[i] & C[i] );
        end
    endgenerate

endmodule