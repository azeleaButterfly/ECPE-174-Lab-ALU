module subtractor (
    input logic [5:0] A, B,
    output logic [5:0] C,
    output logic overflow
);
logic [5:0] tcB;
assign tcB = (~B) + 1;
adder add(.A(A), .B(tcB), .C(C), .overflow(overflow));

endmodule