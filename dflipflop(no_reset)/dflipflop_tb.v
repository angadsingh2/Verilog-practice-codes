`timescale 1ns/1ps

module dflipflop_tb;

    reg clk;
    reg d;
    wire q;

    dflipflop dut (
        .clk(clk),
        .d(d),
        .q(q)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    task check;
        input expected;
        begin
            if (q !== expected)
                $display("FAIL at time %0t: d=%b q=%b expected=%b",
                          $time, d, q, expected);
            else
                $display("PASS at time %0t: d=%b q=%b",
                          $time, d, q);
        end
    endtask

    initial begin
        d = 0;
        #7;   
        d = 1;

        #10;  
        check(1);

        d = 0;
        #10;
        check(0);

        d = 1;
        #10;
        check(1);

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule