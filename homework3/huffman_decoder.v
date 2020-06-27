module huffman_decoder(x, y, clk, reset);
input x, clk, reset;
output [2:0] y;

reg [3:0] state;
reg [3:0] next;


parameter S0 = 4'b0000, A = 4'b0001, B = 4'b0010, C = 4'b0011, D = 4'b0100, E = 4'b0101, F = 4'b0110;
parameter S1 = 4'b1000, S2 = 4'b1001, S3 = 4'b1010, S4 = 4'b1011; 

always @(*)
begin
    case(state)
    S0: if(x) next = S1; else next = A;
    S1: if(x) next = S3; else next = S2;
    S2: if(x) next = B; else next = C;
    S3: if(x) next = D; else next = S4;
    S4: if(x) next = E; else next = F;
    default: if(x) next = S1; else next = A;
    endcase
end

always @(posedge clk or posedge reset)
begin
    if(reset) state <= S0;
    else state <= next;
end

assign y[2] = ~state[3] & state[2];
assign y[1] = ~state[3] & state[1];
assign y[0] = ~state[3] & state[0];

endmodule