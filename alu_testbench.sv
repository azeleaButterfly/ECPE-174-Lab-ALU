module alu_testbench();
    logic [5:0] A = 6'd0;
    logic [5:0] B = 6'd0;
    logic [5:0] C;
    logic [2:0] sel = 3'b000;
    
    alu testAlu (.A(A), .B(B), .sel(sel), .C(C));
    
    logic [5:0] testAsAdd [10] = {6'd5, 6'd31, -6'd5, -6'd31, -6'd31, 6'd7, -6'd15, 6'd25, 6'd19, 6'd0};
    logic [5:0] testBsAdd [10] = {6'd10, 6'd15, -6'd14, -6'd12, 6'd15, -6'd15, 6'd25, -6'd15, 6'd0, 6'd17};
    logic [5:0] exOutAdd [10] = {6'd15, -6'd18, -6'd19, 6'd21, -6'd16, -6'd8, 6'd10, 6'd10, 6'd19, 6'd17};

    logic [5:0] testAsSub [7] = {6'd16,6'd16,-6'd15,-6'd17, 6'd0,6'd21, -6'd31};
    logic [5:0] testBsSub [7] = {6'd1, -6'd18, -6'd16, -6'd5, 6'd1, 6'd0, 6'd5};
    logic [5:0] exOutSub [7] = {6'd15, -6'd30, 6'd1, -6'd12, -6'd1, 6'd21, 6'd28};

    logic [5:0] testAsEq [8] = {6'd5, 6'd2, 6'd13, -6'd15, 6'd19, -6'd3, -6'd25, -6'd15};
    logic [5:0] testBsEq [8] = {6'd3, 6'd15, -6'd24, 6'd15, 6'd19, -6'd10, -6'd4, -6'd15};
    logic [5:0] exOutEq [8] = {6'd0, 6'd0, 6'd0, 6'd0, 6'd1, 6'd0, 6'd0, 6'd1};

    logic [5:0] testAsGT [7] = {6'd5, 6'd2, 6'd13, -6'd15, 6'd19, -6'd3, -6'd25};
    logic [5:0] testBsGT [7] = {6'd3, 6'd15, -6'd24, 6'd15, 6'd19, -6'd10, -6'd4};
    logic [5:0] exOutGT [7] = {6'd1, 6'd0, 6'd1, 6'd0, 6'd0, 6'd1, 6'd0};

    logic [5:0] testAsLT [7] = {6'd5, 6'd2, 6'd13, -6'd15, 6'd19, -6'd3, -6'd25};
    logic [5:0] testBsLT [7] = {6'd3, 6'd15, -6'd24, 6'd15, 6'd19, -6'd10, -6'd4};
    logic [5:0] exOutLT [7] = {6'd0, 6'd1, 6'd0, 6'd1, 6'd0, 6'd0, 6'd1};
    
    task testCase(logic [5:0] testA, logic [5:0] testB, logic [5:0] expectedC);
        A <= testA;
        B <= testB;
        #20 assert (C === expectedC) 
        else $error("Error at time: %t. A: %b, B: %b, sel: %b. C returned %b , expected %b", $time, A,B,sel, C, expectedC);
    endtask 
    
    initial begin
        $display("Testing A+B\n");
        $monitor("Time %t, A: %b, B: %b, C: %b, sel: %b",$time, A,B,C,sel);
        sel <= 3'b000;
        for (int i = 0; i < 10; i++) begin
            #5 testCase(testAsAdd[i], testBsAdd[i], exOutAdd[i]);
        end
        sel <= 3'b001;
        $display("Testing A-B\n");
        for (int i = 0; i < 7; i++) begin
            #5 testCase(testAsSub[i], testBsSub[i], exOutSub[i]);
        end
        sel <= 3'b100;
        $display("Testing A=B\n");
        for (int i =0; i < 8; i++) begin
            #5 testCase(testAsEq[i], testBsEq[i], exOutEq[i]);
        end

        sel <= 3'b101;
        $display("Testing A > B\n");
        for (int i = 0; i < 7; i++) begin
            #5 testCase(testAsGT[i], testBsGT[i], exOutGT[i]);

        end
        sel <= 3'b110;
        $display("Testing A < B\n");
        for (int i = 0; i < 7; i++) begin
            #5 testCase(testAsLT[i], testBsLT[i], exOutLT[i]);
        end

        sel <= 3'b111;
        A <= 6'd0;
        $display("Testing A = 0\n");
        for (int i = 0; i < 64 ; i++) begin
            if (i >= 1) begin
                #10 testCase(A, 6'd0, 6'd0);
            end else begin
                #10 testCase(A, 6'd0, 6'd1);
            end
            
            A <= A + 6'b000001;
        end

        $stop;
    end
endmodule