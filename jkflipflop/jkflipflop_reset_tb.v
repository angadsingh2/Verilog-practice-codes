`timescale 1ns/1ps

module jkflipflop_reset_tb;

    reg j, k;
    reg clk;
    reg reset;
    wire q;

    jkflipflop_reset dut (
        .j(j),
        .k(k),
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    // Clock: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    task check;
        input expected;
        begin
            if (q !== expected)
                $display("FAIL at time %0t: j=%b k=%b reset=%b q=%b expected=%b",
                         $time, j, k, reset, q, expected);
            else
                $display("PASS at time %0t: j=%b k=%b reset=%b q=%b",
                         $time, j, k, reset, q);
        end
    endtask

    initial begin

        // --- Test 1: Reset behavior ---
        reset = 1;
        j = 0; k = 0;
        #2;                 // no clock edge yet
        check(0);           // should reset immediately

        reset = 0;          // release reset

        // --- Test 2: Set (J=1, K=0) ---
        j = 1; k = 0;
        #10;                // wait for clock edge
        check(1);

        // --- Test 3: Reset via JK (J=0, K=1) ---
        j = 0; k = 1;
        #10;
        check(0);

        // --- Test 4: Toggle (J=1, K=1) ---
        j = 1; k = 1;
        #10;
        check(1);
        #10;
        check(0);

        // --- Test 5: Hold (J=0, K=0) ---
        j = 0; k = 0;
        #10;
        check(0);

        // --- Test 6: Async reset during toggle ---
        j = 1; k = 1;
        #3;
        reset = 1;          // assert reset mid-cycle
        #1;
        check(0);           // should clear immediately

        reset = 0;
        #10;

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule