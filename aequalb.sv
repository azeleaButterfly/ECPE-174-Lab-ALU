module aequalb(
    input logic [5:0] A, B,
    output logic [5:0] C 
);
//Compares A = B
always_comb begin
    if (A === B) begin
        C <= 6'b000001; 
    end else begin
        C <= 6'b000000;
    end
end
endmodule
