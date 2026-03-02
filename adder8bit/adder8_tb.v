`timescale 1ns/1ps

module adder8_tb;

    reg  [7:0] a, b;
    reg        cin;
    wire [7:0] sum;
    wire       cout;

    adder8 dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    task check;
        input [8:0] expected;   // 9 bits: carry + 8-bit sum
        begin
            if ({cout, sum} !== expected) begin
                $display("FAIL: a=%0d b=%0d cin=%b | result=%0d | expected=%0d",
                          a, b, cin, {cout,sum}, expected);
            end
            else begin
                $display("PASS: a=%0d b=%0d cin=%b | result=%0d",
                          a, b, cin, {cout,sum});
            end
        end
    endtask

    initial begin

        // Basic tests
        a=0;   b=0;   cin=0; #1; check(9'd0);
        a=10;  b=20;  cin=0; #1; check(9'd30);
        a=255; b=1;   cin=0; #1; check(9'd256);
        a=100; b=50;  cin=1; #1; check(9'd151);

        // Random stress tests
        repeat (20) begin
            a   = $random;
            b   = $random;
            cin = $random % 2;
            #1;
            check(a + b + cin);
        end

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule