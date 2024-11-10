module seven_seg (
input logic [3:0] a,
output logic [0:6] b //A,B,C,D,E,F,G on the diagram
);
always_comb begin : seven
unique case (a)
4'b0000 : b <= 7'b0000001; //0
4'b0001 : b <= 7'b1001111; //1
4'b0010 : b <= 7'b0010010; //2
4'b0011 : b <= 7'b0000110; //3
4'b0100 : b <= 7'b1001100; //4
4'b0101 : b <= 7'b0100100; //5
4'b0110 : b <= 7'b0100000; //6
4'b0111 : b <= 7'b0001111; //7
4'b1000 : b <= 7'b0000000; //8
4'b1001 : b <= 7'b0001100; //9
4'b1010 : b <= 7'b0001000; //A
4'b1011 : b <= 7'b1100000; //B
4'b1100 : b <= 7'b0110001; //C
4'b1101 : b <= 7'b1000010; //D
4'b1110 : b <= 7'b0110000; //E
4'b1111 : b <= 7'b0111000; //F
default : b <= 7'b1111111; //off
endcase
end
endmodule