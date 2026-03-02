`timescale 1ns/1ps

module adder4_tb;

    reg  [3:0] a, b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;

    // DUT
    adder4 dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    task check;
        input [4:0] expected;   // 5-bit to include carry
        begin
            if ({cout, sum} !== expected) begin
                $display(
                    "FAIL: a=%d b=%d cin=%b | sum=%d cout=%b | expected=%d",
                    a, b, cin, sum, cout, expected
                );
            end else begin
                $display(
                    "PASS: a=%d b=%d cin=%b | sum=%d cout=%b",
                    a, b, cin, sum, cout
                );
            end
        end
    endtask

    initial begin
        // Basic tests
        a=0;  b=0;  cin=0; #1; check(5'd0);
        a=3;  b=4;  cin=0; #1; check(5'd7);
        a=7;  b=8;  cin=0; #1; check(5'd15);

        // Carry-in tests
        a=5;  b=5;  cin=1; #1; check(5'd11);

        // Overflow tests
        a=15; b=1;  cin=0; #1; check(5'd16);
        a=15; b=15; cin=1; #1; check(5'd31);

        // Random tests
        repeat (10) begin
            a   = $random % 16;
            b   = $random % 16;
            cin = $random % 2;
            #1;
            check(a + b + cin);
        end

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule