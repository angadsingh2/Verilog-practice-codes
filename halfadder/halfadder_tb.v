`timescale 1ns/1ps

module halfadder_tb;

    reg a, b;
    wire adder, carry;

    // DUT
    halfadder dut (
        .a(a),
        .b(b),
        .adder(adder),
        .carry(carry)
    );

    task check;
        input exp_adder;
        input exp_carry;
        begin
            if (adder !== exp_adder || carry !== exp_carry) begin
                $display("FAIL: a=%b b=%b | adder=%b carry=%b | expected adder=%b carry=%b",
                          a, b, adder, carry, exp_adder, exp_carry);
            end else begin
                $display("PASS: a=%b b=%b | adder=%b carry=%b",
                          a, b, adder, carry);
            end
        end
    endtask

    initial begin
        a = 0; b = 0; #1; check(0, 0);
        a = 0; b = 1; #1; check(1, 0);
        a = 1; b = 0; #1; check(1, 0);
        a = 1; b = 1; #1; check(0, 1);

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule