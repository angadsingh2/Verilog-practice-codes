`timescale 1ns/1ps

module universal_shift_register_tb;

reg clk;
reg reset;
reg [1:0] mode;
reg serial_left;
reg serial_right;
reg [3:0] data_in;
wire [3:0] data_out;

universal_shift_register #(.N(4)) dut (
    .clk(clk),
    .reset(reset),
    .mode(mode),
    .serial_left(serial_left),
    .serial_right(serial_right),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    $display("Time\tMode\tData_Out");

    reset = 1;
    mode = 2'b00;
    serial_left = 0;
    serial_right = 0;
    data_in = 4'b0000;

    #12;
    reset = 0;

    // Parallel load
    mode = 2'b11;
    data_in = 4'b1011;
    #10;

    // Shift right
    mode = 2'b01;
    serial_right = 0;
    #10;

    // Shift right again
    #10;

    // Shift left
    mode = 2'b10;
    serial_left = 1;
    #10;

    // Hold
    mode = 2'b00;
    #10;

    $finish;

end

always #10
    $display("%0t\t%b\t%b", $time, mode, data_out);

endmodule