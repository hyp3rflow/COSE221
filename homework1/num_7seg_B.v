module num_7seg_B(out, w, x, y, z);

input w, x, y, z;
output out;

assign out = w | (~y & ~z) | (~y & x) | (~z & x);

endmodule
