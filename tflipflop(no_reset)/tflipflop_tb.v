`timescale 1ns/1ps

module tflipflop_tb;

    reg t;
    reg clk;
    wire q;

    tflipflop dut (
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
                $display("FAIL at time %0t: t=%b q=%b expected=%b",
                         $time, t, q, expected);
            else
                $display("PASS at time %0t: t=%b q=%b",
                         $time, t, q);
        end
    endtask

    initial begin

        // Initial state unknown → wait first clock
        t = 0;
        #10;

        // --- Test Hold (t=0) ---
        t = 0;
        #10;
        check(q);   // should not change

        // --- Test Toggle (t=1) ---
        t = 1;
        #10;
        check(1);

        #10;
        check(0);

        #10;
        check(1);

        // --- Back to Hold ---
        t = 0;
        #10;
        check(1);

        #10;
        check(1);

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule