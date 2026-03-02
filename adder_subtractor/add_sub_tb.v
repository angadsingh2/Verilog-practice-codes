`timescale 1ns/1ps

module add_sub_tb;

    parameter N = 8;

    reg  [N-1:0] A, B;
    reg          sub;
    wire [N-1:0] result;
    wire         cout;
    wire         overflow;

    add_sub #(.N(N)) dut (
        .A(A),
        .B(B),
        .sub(sub),
        .result(result),
        .cout(cout),
        .overflow(overflow)
    );

    task check;
        reg signed [N:0] expected_signed;
        reg [N:0]        expected_unsigned;
        begin
            if (sub == 0) begin
                expected_unsigned = A + B;
                expected_signed   = $signed(A) + $signed(B);
            end else begin
                expected_unsigned = A - B;
                expected_signed   = $signed(A) - $signed(B);
            end

            if ({cout, result} !== expected_unsigned) begin
                $display("FAIL (UNSIGNED): A=%0d B=%0d sub=%b result=%0d expected=%0d",
                         A, B, sub, {cout,result}, expected_unsigned);
            end
            else begin
                $display("PASS (UNSIGNED): A=%0d B=%0d sub=%b result=%0d",
                         A, B, sub, {cout,result});
            end

            if (overflow !== 
               (expected_signed >  (2**(N-1)-1) ||
                expected_signed < -(2**(N-1)))) begin
                $display("FAIL (OVERFLOW): A=%0d B=%0d sub=%b overflow=%b",
                         $signed(A), $signed(B), sub, overflow);
            end
        end
    endtask

    initial begin

        // Basic add tests
        A=10;  B=20;  sub=0; #1; check();
        A=127; B=1;   sub=0; #1; check();  // signed overflow
        A=255; B=1;   sub=0; #1; check();  // unsigned carry

        // Basic subtract tests
        A=50;  B=20;  sub=1; #1; check();
        A=20;  B=50;  sub=1; #1; check();  // negative result
        A=128; B=1;   sub=1; #1; check();  // signed overflow case

        // Random stress tests
        repeat (25) begin
            A   = $random;
            B   = $random;
            sub = $random % 2;
            #1;
            check();
        end

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule