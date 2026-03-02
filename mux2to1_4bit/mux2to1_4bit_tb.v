`timescale 1ns/1ps

module mux2to1_4bit_tb;

    reg  [3:0] a, b;
    reg        sel;
    wire [3:0] y;

    mux2to1_4bit dut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    task check;
        input [3:0] expected;
        begin
            if (y !== expected) begin
                $display(
                    "FAIL: sel=%b a=%d b=%d | y=%d | expected=%d",
                    sel, a, b, y, expected
                );
            end else begin
                $display(
                    "PASS: sel=%b a=%d b=%d | y=%d",
                    sel, a, b, y
                );
            end
        end
    endtask

    initial begin
        // Basic tests
        a=4'd3;  b=4'd7;  sel=0; #1; check(4'd3);
        a=4'd3;  b=4'd7;  sel=1; #1; check(4'd7);

        // Edge cases
        a=4'd0;  b=4'd15; sel=0; #1; check(4'd0);
        a=4'd0;  b=4'd15; sel=1; #1; check(4'd15);

        // Random tests
        repeat (10) begin
            a   = $random % 16;
            b   = $random % 16;
            sel = $random % 2;
            #1;
            check(sel ? b : a);
        end

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule