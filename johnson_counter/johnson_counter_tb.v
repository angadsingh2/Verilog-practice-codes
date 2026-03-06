`timescale 1ns/1ps

module johnson_counter_tb;

    reg clk;
    reg reset;
    wire [3:0] count;

    johnson_counter dut(
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

        reset = 1;
        #12;
        reset = 0;

        repeat(12) begin
            #10;
            $display("%0t\t%b\t%b", $time, reset, count);
        end

        $finish;

    end

endmodule