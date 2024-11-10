module alessb(
    input logic [5:0] A, B,
	output logic [5:0] C 
);
/* Two's Compliment Comparator A < B */
logic [5:0] tempA, tempB;
assign tempA = ~A + 6'b000001;
assign tempB = ~B + 6'b000001;

always_comb begin
    if (A[5] == 1'b0 && B[5] === 1'b0) begin //Both A & B are positive
        if (A < B) begin
            C <= 6'b000001; 
        end else begin
            C <= 6'b000000;
        end  
    end else if (A[5] === 1'b1 && B[5] === 1'b0) begin //A is negative, B is positive
        C <= 6'b000001;
    end else if (A[5] === 1'b0 && B[5] === 1'b1) begin//A is postive, B is negative
        C <= 6'b000000;
    end else begin //Both A&B are negative
        if (tempA < tempB) begin //Compare magnitudes.
            C <= 6'b000000;  
        end else begin
            C <= 6'b000001;
        end
    end
end
endmodule
