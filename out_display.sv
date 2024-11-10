module out_display (
    input logic [5:0] C, input logic[2:0] instr,
    output logic [0:6] display0, display1,display2 //Only need 3 displays because our values are no more than 2 digits in decimal
);
logic [5:0] dispedVal;
logic [3:0] tens_place; //The displays need seperate vals
logic [3:0] ones_place;

always_comb begin
    if (C[5] === 1'b1) begin
    display2 <= 7'b1111110; //Negative Sign
    dispedVal <= ~C + 6'h01; //C <= twos compilment of C
    end else begin
        display2 <= 7'b1111111; //Not negative, leave disp 2 blank
        dispedVal <= C;
    end
    if (instr[2] === 1'b1) begin
        display1 <= 7'b1111111;
        if (dispedVal === 6'b000001) begin
            display0 <=  7'b1001111;
        end else begin 
            display0 <= 7'b0000001;
        end
    end else if (instr === 3'b011 || instr === 3'b010) begin
        display1 <= 7'b1111110; //Invalid Instruction, display error on display1 nd 2
        display0 <= 7'b1111110; 
    end else begin
         unique case (dispedVal) //Assign seven 7 segment display values A,B,C,D,E,F,G
        6'd0:  begin 
            display1 <= 7'b0000001; display0 <= 7'b0000001; end
        6'd1:  begin 
            display1 <= 7'b0000001; display0 <= 7'b1001111; end
        6'd2:  begin 
            display1 <= 7'b0000001; display0 <= 7'b0010010; end
        6'd3:  begin 
            display1 <= 7'b0000001; display0 <= 7'b0000110; end
        6'd4:  begin 
            display1 <= 7'b0000001; display0 <= 7'b1001100; end
        6'd5:  begin 
            display1 <= 7'b0000001; display0 <= 7'b0100100; end
        6'd6:  begin 
            display1 <= 7'b0000001; display0 <= 7'b0100000; end
        6'd7:  begin 
            display1 <= 7'b0000001; display0 <= 7'b0001111; end
        6'd8:  begin 
            display1 <= 7'b0000001; display0 <= 7'b0000000; end
        6'd9:  begin 
            display1 <= 7'b0000001; display0 <= 7'b0001100; end
        6'd10: begin 
            display1 <= 7'b1001111; display0 <= 7'b0000001; end
        6'd11: begin 
            display1 <= 7'b1001111; display0 <= 7'b1001111; end
        6'd12: begin 
            display1 <= 7'b1001111; display0 <= 7'b0010010; end
        6'd13: begin 
            display1 <= 7'b1001111; display0 <= 7'b0000110; end
        6'd14: begin 
            display1 <= 7'b1001111; display0 <= 7'b1001100; end
        6'd15: begin 
            display1 <= 7'b1001111; display0 <= 7'b0100100; end
        6'd16: begin 
            display1 <= 7'b1001111; display0 <= 7'b0100000; end
        6'd17: begin 
            display1 <= 7'b1001111; display0 <= 7'b0001111; end
        6'd18: begin 
            display1 <= 7'b1001111; display0 <= 7'b0000000; end
        6'd19: begin 
            display1 <= 7'b1001111; display0 <= 7'b0001100; end 
        6'd20: begin 
            display1 <= 7'b0010010; display0 <= 7'b0000001; end
        6'd21: begin 
            display1 <= 7'b0010010; display0 <= 7'b1001111; end
        6'd22: begin 
            display1 <= 7'b0010010; display0 <= 7'b0010010; end
        6'd23: begin 
            display1 <= 7'b0010010; display0 <= 7'b0000110; end
        6'd24: begin 
            display1 <= 7'b0010010; display0 <= 7'b1001100; end
        6'd25: begin 
            display1 <= 7'b0010010; display0 <= 7'b0100100; end
        6'd26: begin 
            display1 <= 7'b0010010; display0 <= 7'b0100000; end
        6'd27: begin 
            display1 <= 7'b0010010; display0 <= 7'b0001111; end
        6'd28: begin 
            display1 <= 7'b0010010; display0 <= 7'b0000000; end
        6'd29: begin 
            display1 <= 7'b0010010; display0 <= 7'b0001100; end
        6'd30: begin 
            display1 <= 7'b0000110; display0 <= 7'b0000001; end 
        6'd31: begin 
            display1 <= 7'b0000110; display0 <= 7'b1001111; end
        6'd32: begin 
            display1 <= 7'b0000110; display0 <= 7'b0010010; end
        default: begin display1 <= 7'b1111110; display0 <= 7'b1111110; end
    endcase 
    end
    end



endmodule