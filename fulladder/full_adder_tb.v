`timescale 1ns/1ps

module full_adder_tb;

    reg a, b, cin;
    wire sum, cout;

    full_adder dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    task check;
        input exp_sum;
        input exp_cout;
        begin
            if (sum !== exp_sum || cout !== exp_cout) begin
                $display("FAIL: a=%b b=%b cin=%b | sum=%b cout=%b | expected sum=%b cout=%b",
                          a, b, cin, sum, cout, exp_sum, exp_cout);
            end else begin
                $display("PASS: a=%b b=%b cin=%b | sum=%b cout=%b",
                          a, b, cin, sum, cout);
            end
        end
    endtask

    initial begin
        a=0; b=0; cin=0; #1; check(0,0);
        a=0; b=0; cin=1; #1; check(1,0);
        a=0; b=1; cin=0; #1; check(1,0);
        a=0; b=1; cin=1; #1; check(0,1);
        a=1; b=0; cin=0; #1; check(1,0);
        a=1; b=0; cin=1; #1; check(0,1);
        a=1; b=1; cin=0; #1; check(0,1);
        a=1; b=1; cin=1; #1; check(1,1);

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule