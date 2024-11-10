module alu (
    input logic [5:0] A, B,
    input logic [2:0] sel,
    output logic [5:0] C
);

logic [5:0] outVals[6];
logic over0, over1;
adder add(.A(A), .B(B), .C(outVals[0]), .overflow(over0));
subtractor sub(.A(A), .B(B), .C(outVals[1]), .overflow(over1));
aequalb equality(.A(A), .B(B), .C(outVals[2]));
alessb less_than(.A(A), .B(B), .C(outVals[3]));
agreaterb greater_than(.A(A), .B(B), .C(outVals[4]));
aequalzero equal_zero(.A(A), .C(outVals[5]));
always_comb begin
    case (sel)
        3'b000:
        C <= outVals[0];
        3'b001:
        C <= outVals[1];
        3'b100:
        C <= outVals[2];
        3'b101:
        C <= outVals[4];
        3'b110:
        C <= outVals[3];
        3'b111:
        C <= outVals[5];
        default: 
        C <= 6'b000000;
    endcase
end
 
endmodule