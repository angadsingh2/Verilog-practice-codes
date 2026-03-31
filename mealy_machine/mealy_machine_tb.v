`timescale 1ns/1ps

module mealy_machine_tb;

reg clk;
reg reset;
reg din;
wire dout;

mealy_machine dut(
    .clk(clk),
    .reset(reset),
    .din(din),
    .dout(dout)
);

// clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;  
end

initial begin

    $display("Time\tReset\tInput\tDetect");

    reset = 1;
    din = 0;

    #12;
    reset = 0;

    // Test sequence: 1 0 1 0 1 1 0 1
    #10 din = 1;
    #10 din = 0;
    #10 din = 1;   // detect
    #10 din = 0;
    #10 din = 1;   // detect
    #10 din = 1;
    #10 din = 0;
    #10 din = 1;   // detect

    #20;

    $finish;

end

initial begin
    $monitor("%0t\t%b\t%b\t%b", $time, reset, din, dout);
end

endmodule