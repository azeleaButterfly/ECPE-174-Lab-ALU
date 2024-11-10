module aequalzero_testbench();
    logic [5:0] A = 6'd0, C;
    aequalzero test (.A(A), .C(C));
    task testCase (logic [5:0] testA, logic[5:0] expectedC, int testNum);
        A <= testA;
        #25 assert (C === expectedC) 
        else  $error("Error at case %d: C = %b, Expected: %b", testNum, C, expectedC);
    endtask
    
    initial begin
        $monitor("Time %t: A = %b, C = %b", $time, A, C);
        for (int i = 0; i < 64 ; i++) begin
            if (i >= 1) begin
                #10 testCase(A, 6'd0, i + 1);
            end else begin
                #10 testCase(A, 6'd1, i + 1);
            end
            
            A <= A + 6'b000001;
        end
        $stop;
    end


endmodule