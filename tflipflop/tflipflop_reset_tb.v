`timescale 1ns/1ps

module tflipflop_reset_tb;

    reg reset;
    reg t;
    reg clk;
    wire q;

    tflipflop_reset dut (
        .reset(reset),
        .t(t),
        .clk(clk),
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
                $display("FAIL at time %0t: reset=%b t=%b q=%b expected=%b",
                         $time, reset, t, q, expected);
            else
                $display("PASS at time %0t: reset=%b t=%b q=%b",
                         $time, reset, t, q);
        end
    endtask

    initial begin

        // --- Test 1: Reset ---
        reset = 1;
        t = 0;
        #2;               // no clock edge needed (async reset)
        check(0);

        reset = 0;

        // --- Test 2: Toggle ---
        t = 1;
        #10;              // first clock edge
        check(1);

        #10;              // next clock edge
        check(0);

        #10;
        check(1);

        // --- Test 3: Hold ---
        t = 0;
        #10;
        check(1);

        #10;
        check(1);

        // --- Test 4: Async reset mid-cycle ---
        t = 1;
        #3;
        reset = 1;        // assert reset between clock edges
        #1;
        check(0);         // should reset immediately

        reset = 0;
        #10;
        check(1);

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule