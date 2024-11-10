module lab9(
input logic [14:0] switches,
input logic clk, rst, key, rw,
output logic [0:6] disp0, disp1, disp2, disp7,
output logic [14:0] switch_leds,
output logic rw_led
);
logic [5:0] A,B,C;
logic [2:0] instr;
logic [2:0] out_addr;
logic [3:0] disp_addr;
memory_system memorySys (.i_data(switches), .clk(clk), .rst(rst), .key(key), .rw(rw), .instruction(instr), .A(A), .B(B), .out_address(out_addr));
alu aluSys (.A(A), .B(B), .sel(instr), .C(C));
out_display display(.C(C), .instr(instr), .display0(disp0),.display1(disp1), .display2(disp2));
seven_seg(.a(disp_addr), .b(disp7));
always begin
    switch_leds[14:12] <= instr;
    switch_leds[11:6] <= A;
    switch_leds[5:0] <= B;
    rw_led <= rw;
    disp_addr <= {1'b0, out_addr[2], out_addr[1], out_addr[0]};
end
endmodule