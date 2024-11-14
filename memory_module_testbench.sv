module memory_module_testbench();
logic [14:0] in_data = 15'd0;
logic [2:0] addr = 3'b000;
logic we = 1'b0;
logic clk = 1'b0;
logic rst = 1'b0;
logic [14:0] out_data;


logic[2:0] test_read_addr = 3'b000;
always begin
    #50 clk <= ~clk;
end

memory_module test_module (.in_data(in_data), .addr(addr), .we(we), .rst(rst), .clk(clk), .out_data(out_data));

task read_test(logic [2:0] test_addr);
    we <= 1'b0;
    @(negedge clk)
        addr <= test_addr;
    @(posedge clk)
        #10 $display("Value of out_data at addr %x : %x", addr, out_data);
endtask 

logic [14:0] writeVals [8] = {15'd2747 ,15'd7503, 15'd29928, 15'd4993, 15'd27060, 15'd17640, 15'd32641, 15'd2562}; //Generating using Matlab randi(32767,1,10)
task write_test(logic [2:0] test_addr, logic [14:0] write_data);
    @(negedge clk)
        addr <= test_addr;
        in_data <= write_data;
        we <= 1'b1;
    @(posedge clk)
        #10 $display("write_data: %x, out_data: %x , addr: %x", write_data, out_data, addr);
        #15 assert (write_data === out_data) 
        else  $error("Error at time %t", $time);
        

endtask

initial begin
    for (int i = 0; i< 10; i++)begin
        #10 read_test(test_read_addr);
        #5 test_read_addr <= test_read_addr + 3'b001;
    end
    test_read_addr <= 3'b000;
    for (int i = 0; i < 8; i++) begin
        #5 write_test(test_read_addr, writeVals[i]);
        #5 test_read_addr <= test_read_addr + 3'b001;
    end
    test_read_addr <= 3'b000;
    for (int i = 0; i< 10; i++)begin
        #10 read_test(test_read_addr);
        #5 test_read_addr <= test_read_addr + 3'b001;
    end

    rst <= 1'b1;
    #400
    assert(out_data === 15'd0)
    else $error("Error: RST Does not work");


    $stop;
end

endmodule