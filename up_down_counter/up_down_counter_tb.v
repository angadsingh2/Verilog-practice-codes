`timescale 1ns/1ps

module up_down_counter_tb;

    reg clk;
    reg reset;
    reg dir;
    wire [3:0] count;

    up_down_counter dut (
        .clk(clk),
        .reset(reset),
        .dir(dir),
        .count(count)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        $display("Time\tReset\tDir\tCount");

        // Apply reset
        reset = 1;
        dir = 1;
        #12;

        reset = 0;

        // Count UP
        dir = 1;
        repeat(8) begin
            #10;
            $display("%0t\t%b\t%b\t%b", $time, reset, dir, count);
        end

        // Count DOWN
        dir = 0;
        repeat(8) begin
            #10;
            $display("%0t\t%b\t%b\t%b", $time, reset, dir, count);
        end

        // Reset again
        reset = 1;
        #10;
        $display("%0t\t%b\t%b\t%b (after reset)", $time, reset, dir, count);

        reset = 0;

        repeat(4) begin
            #10;
            $display("%0t\t%b\t%b\t%b", $time, reset, dir, count);
        end

        $display("Simulation finished");
        $finish;

    end

endmodule