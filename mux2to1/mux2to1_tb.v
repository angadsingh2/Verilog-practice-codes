`timescale 1ns/1ps

module mux2to1_tb;

    reg a, b, sel;
    wire out;

    // Device Under Test
    mux2to1 dut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        // Waveform dump
        $dumpfile("sim/dump.vcd");
        $dumpvars(0, mux2to1_tb);

        // Test cases
        a = 0; b = 0; sel = 0;   // expect out = 0
        #10 a = 1;               // expect out = 1
        #10 sel = 1;             // expect out = 0
        #10 b = 1;               // expect out = 1
        #10 sel = 0;             // expect out = 1
        #10;

        $finish;
    end

endmodule