module memory_system (
    input logic [14:0] i_data,
    input logic rw, clk, key, rst, //RW = 0 -> read, RW = 1 -> write
    output  logic [2:0] instruction,
    output logic [5:0] A,B,
    output logic [2:0] out_address
);
logic [14:0] o_data;
logic [3:0] disp3_val;
logic [2:0] out_addr;
always begin
end
 
logic synced_key, divdClk, synced_rst;
assign disp3_val = {1'b0, o_data[14], o_data[13], o_data[12]};
mem_control memory_controller(.rw(rw), .clk(divdClk), .key(synced_key), .rst(synced_rst), .out_addr(out_addr), .full(full), .empty(empty));
memory_module mem_module(.in_data(i_data), .addr(out_addr), .clk(divdClk), .rst(synced_rst), .we(rw), .out_data(o_data));
synchronizer key_sync (.key(key), .clk(divdClk), .ctrl(synced_key));
synchronizer rst_sync(.key(rst), .clk(divdClk), .ctrl(synced_rst));
clockdiv clockdivider(.iclk(clk), .oclk(divdClk));
always_comb begin
    instruction <= o_data[14:12];
    A <= o_data[11:6];
    B <= o_data[5:0];
    out_address <= out_addr;
end
    
endmodule