`timescale 1ns/1ps

module jkflipflop_tb;

    reg j, k;
    reg clk;
    wire q;

    jkflipflop dut (
        .j(j),
        .k(k),
        .clk(clk),
        .q(q)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    task check;
        input expected;
        begin
            if (q !== expected)
                $display("FAIL at time %0t: j=%b k=%b q=%b expected=%b",
                         $time, j, k, q, expected);
            else
                $display("PASS at time %0t: j=%b k=%b q=%b",
                         $time, j, k, q);
        end
    endtask

    initial begin

        // Initial state unknown → wait one cycle
        j=0; k=0;
        #10;

        // Set (J=1, K=0)
        j=1; k=0;
        #10;
        check(1);

        // Reset (J=0, K=1)
        j=0; k=1;
        #10;
        check(0);

        // Toggle (J=1, K=1)
        j=1; k=1;
        #10;
        check(1);
        #10;
        check(0);

        // Hold (J=0, K=0)
        j=0; k=0;
        #10;
        check(0);

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule   