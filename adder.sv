module adder (
    input logic [5:0] A, B,
    output logic [5:0] C,
    output logic overflow
);
assign C = A + B;
always_comb begin
    if ( (C[5] == 1'b1 && A[5] == 1'b0 && B[5] == 1'b0) || (C[5] == 1'b0 && A[5] == 1'b1 && B[5] == 1'b1)) begin
        overflow <= 1'b1;
    end else begin
        overflow <= 1'b0;
    end
end

endmodule