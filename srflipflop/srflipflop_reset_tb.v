`timescale 1ns/1ps

module srflipflop_reset_tb;

    reg s, r;
    reg reset;
    reg clk;
    wire q;

    srflipflop_reset dut (
        .s(s),
        .r(r),
        .reset(reset),
        .clk(clk),
        .q(q)
    );

    // 10ns clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    task check;
        input expected;
        begin
            if (q !== expected)
                $display("FAIL at %0t: s=%b r=%b reset=%b q=%b expected=%b",
                         $time, s, r, reset, q, expected);
            else
                $display("PASS at %0t: s=%b r=%b reset=%b q=%b",
                         $time, s, r, reset, q);
        end
    endtask

    initial begin

        // --- Test 1: Async reset ---
        reset = 1;
        s = 0; r = 0;
        #2;                 // no clock edge
        check(0);           // should reset immediately

        reset = 0;

        // --- Test 2: Set ---
        s = 1; r = 0;
        #10;                // wait for posedge
        check(1);

        // --- Test 3: Reset via SR ---
        s = 0; r = 1;
        #10;
        check(0);

        // --- Test 4: Hold ---
        s = 0; r = 0;
        #10;
        check(0);

        // --- Test 5: Invalid state ---
        s = 1; r = 1;
        #10;
        if (q === 1'bx)
            $display("PASS: Invalid state produces X");
        else
            $display("FAIL: Invalid state did not produce X");

        // --- Test 6: Reset during invalid ---
        #3;
        reset = 1;
        #1;
        check(0);           // reset overrides everything

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule