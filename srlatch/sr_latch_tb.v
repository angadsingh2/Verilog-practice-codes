`timescale 1ns/1ps

module sr_latch_tb;

    reg s, r;
    wire q;

    sr_latch dut (
        .s(s),
        .r(r),
        .q(q)
    );

    task check;
        input expected;
        begin
            if (q !== expected)
                $display("FAIL at %0t: s=%b r=%b q=%b expected=%b",
                         $time, s, r, q, expected);
            else
                $display("PASS at %0t: s=%b r=%b q=%b",
                         $time, s, r, q);
        end
    endtask

    initial begin

        s=0; r=0; #1;

        // Set
        s=1; r=0; #1; check(1);

        // Hold
        s=0; r=0; #1; check(1);

        // Reset
        s=0; r=1; #1; check(0);

        // Hold
        s=0; r=0; #1; check(0);

        // Invalid
        s=1; r=1; #1;
        if (q === 1'bx)
            $display("PASS: Invalid state gives X");
        else
            $display("FAIL: Invalid state not X");

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule