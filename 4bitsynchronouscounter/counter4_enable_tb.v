`timescale 1ns/1ps

module counter4_enable_tb;

    reg clk;
    reg reset;
    reg enable;
    wire [3:0] count;

    counter4_enable dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        $display("Time\tReset\tEnable\tCount");

        // Reset system
        reset = 1;
        enable = 0;
        #12;

        reset = 0;

        // Enable counting
        enable = 1;
        repeat (10) begin
            #10;
            $display("%0t\t%b\t%b\t%b", $time, reset, enable, count);
        end

        // Disable counting (should freeze)
        enable = 0;
        repeat (5) begin
            #10;
            $display("%0t\t%b\t%b\t%b", $time, reset, enable, count);
        end

        // Enable again
        enable = 1;
        repeat (5) begin
            #10;
            $display("%0t\t%b\t%b\t%b", $time, reset, enable, count);
        end

        // Reset while running
        reset = 1;
        #10;
        $display("%0t\t%b\t%b\t%b (after reset)", $time, reset, enable, count);

        $finish;

    end

endmodule