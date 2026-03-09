`timescale 1ns/1ps

module serial_tx_tb;

reg clk;
reg reset;
reg start;
reg [7:0] data_in;

wire tx;
wire busy;
wire done;

serial_tx #(.DATA_WIDTH(8)) dut(
    .clk(clk),
    .reset(reset),
    .start(start),
    .data_in(data_in),
    .tx(tx),
    .busy(busy),
    .done(done)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    reset = 1;
    start = 0;
    data_in = 8'b10110010;

    #12;
    reset = 0;

    #10;
    start = 1;

    #10;
    start = 0;

    #200;

    $finish;

end

endmodule