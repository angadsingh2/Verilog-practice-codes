`timescale 1ns/1ps

module srflipflop_tb;

    reg s, r;
    reg clk;
    wire q;

    srflipflop dut (
        .s(s),
        .r(r),
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
                $display("FAIL at time %0t: s=%b r=%b q=%b expected=%b",
                         $time, s, r, q, expected);
            else
                $display("PASS at time %0t: s=%b r=%b q=%b",
                         $time, s, r, q);
        end
    endtask

    initial begin

        // Initial cycle
        s=0; r=0;
        #10;

        // --- Set ---
        s=1; r=0;
        #10;
        check(1);

        // --- Reset ---
        s=0; r=1;
        #10;
        check(0);

        // --- Hold ---
        s=0; r=0;
        #10;
        check(0);

        // --- Invalid (S=1, R=1) ---
        s=1; r=1;
        #10;
        if (q === 1'bx)
            $display("PASS: Invalid state produces X");
        else
            $display("FAIL: Invalid state did not produce X");

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule