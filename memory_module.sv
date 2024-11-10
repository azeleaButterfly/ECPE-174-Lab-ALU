module memory_module (
    input logic [14:0] in_data, 
    input logic [2:0] addr,
    input logic we, clk, rst,
    output logic [14:0] out_data
);
//Initializing the ram to the values of the addresses
logic [14:0] ram [0:7] = '{15'h0000, 15'h0001, 15'h0002, 15'h0003, 15'h0004, 15'h0005, 15'h0006, 15'h0007}; 
//From the quartus example
logic [2:0] addr_reg;

always @(posedge clk)
begin
    
    if (we) begin
        ram[addr] <= in_data;
    end

    addr_reg <= addr;
    
    if (!rst) begin
        out_data <= ram[addr_reg];
    end else begin
        out_data <= 15'd0;
    end
end


endmodule