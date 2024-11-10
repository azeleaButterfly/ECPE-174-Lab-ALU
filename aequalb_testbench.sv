module aequalb_testbench ();
    logic [5:0] A = 6'd0,B = 6'd0,C;
    aequalb test (.A(A), .B(B), .C(C));
    logic [5:0] testAs [8] = {6'd5, 6'd2, 6'd13, -6'd15, 6'd19, -6'd3, -6'd25, -6'd15};
    logic [5:0] testBs [8] = {6'd3, 6'd15, -6'd24, 6'd15, 6'd19, -6'd10, -6'd4, -6'd15};
    logic [5:0] expectedCs [8] = {6'd0, 6'd0, 6'd0, 6'd0, 6'd1, 6'd0, 6'd0, 6'd1};
    task testCase (logic [5:0] testA, logic [5:0] testB, logic[5:0] expectedC, int testNum);
    A <= testA;
    B <= testB;
    #25 assert (C === expectedC) 
    else  $error("Error at case %d: C = %b, Expected: %b", testNum, C, expectedC);
    endtask
    
    initial begin
        $monitor("Time %t: A = %b, B = %b, C = %b", $time, A, B, C);
        for (int i = 0; i < 8 ; i++) begin
            #10 testCase(testAs[i], testBs[i], expectedCs[i], i + 1);
        end
        $stop;
    end


endmodule