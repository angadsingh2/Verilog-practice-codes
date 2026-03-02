`timescale 1ns/1ps

module dflipflop_reset_tb;

    reg clk;
    reg d;
    reg reset;
    wire q;

    dflipflop_reset dut (
        .d(d),
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
                $display("FAIL at time %0t: q=%b expected=%b", $time, q, expected);
            else
                $display("PASS at time %0t: q=%b", $time, q);
        end
    endtask

    initial begin

        // Start with reset asserted
        reset = 1;
        d     = 0;
        #2;
        check(0);   // should reset immediately

        // Release reset
        reset = 0;
        d = 1;

        #10;  // wait for clock edge
        check(1);

        d = 0;
        #10;
        check(0);

        // Assert reset in middle of cycle (async behavior)
        d = 1;
        #3;
        reset = 1;
        #1;
        check(0);   // should reset immediately (no clock edge needed)

        reset = 0;
        #10;
        check(1);

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule