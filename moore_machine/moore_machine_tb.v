`timescale 1ns/1ps

module moore_machine_tb;

reg clk;
reg reset;
reg din;
wire detected;

moore_machine dut (
    .clk(clk),
    .reset(reset),
    .din(din),
    .detected(detected)
);

// clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    $display("Time\tReset\tInput\tDetected");

    reset = 1;
    din = 0;

    #12;
    reset = 0;

    // Apply sequence: 1 0 1 0 1 1 0 1
    #10 din = 1;
    #10 din = 0;
    #10 din = 1;   // first 101 detected here
    #10 din = 0;
    #10 din = 1;   // second 101 detected
    #10 din = 1;
    #10 din = 0;
    #10 din = 1;   // third possible detection

    #20;

    $finish;

end

// monitor values
initial begin
    $monitor("%0t\t%b\t%b\t%b", $time, reset, din, detected);
end

endmodule