module aequalzero(
    input logic [5:0] A,
    output logic [5:0] C 
);
//Checks if A = 0
always_comb begin
    if (A === 6'b000000) begin
        C <= 6'b000001; 
    end else begin
        C <= 6'b000000;
    end
end
endmodule
