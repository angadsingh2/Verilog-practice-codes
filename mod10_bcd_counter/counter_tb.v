`timescale 1ns/1ps

module counter_tb;

    reg clk;
    reg reset;
    wire [3:0] count;

    counter dut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        $display("Time\tReset\tCount");

        // Apply reset
        reset = 1;
        #12;
        reset = 0;

        // Let counter run for several cycles
        repeat(15) begin
            #10;
            $display("%0t\t%b\t%b", $time, reset, count);
        end

        // Reset again
        reset = 1;
        #10;
        $display("%0t\t%b\t%b (after reset)", $time, reset, count);

        reset = 0;

        repeat(5) begin
            #10;
            $display("%0t\t%b\t%b", $time, reset, count);
        end

        $display("Simulation finished");
        $finish;

    end

endmodule