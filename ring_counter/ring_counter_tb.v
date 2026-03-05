`timescale 1ns/1ps

module ring_counter_tb;

    reg clk;
    reg reset;
    wire [3:0] count;

    ring_counter dut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        $display("Time\tReset\tCount");

        // apply reset
        reset = 1;
        #12;
        reset = 0;

        // observe ring behavior
        repeat(10) begin
            #10;
            $display("%0t\t%b\t%b", $time, reset, count);
        end

        // reset again
        reset = 1;
        #10;
        $display("%0t\t%b\t%b (after reset)", $time, reset, count);

        reset = 0;

        repeat(6) begin
            #10;
            $display("%0t\t%b\t%b", $time, reset, count);
        end

        $display("Simulation finished");
        $finish;

    end

endmodule
