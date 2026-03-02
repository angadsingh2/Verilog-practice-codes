`timescale 1ns/1ps

module mux4to1_tb;

    reg d0, d1, d2, d3;
    reg [1:0] sel;
    wire y;

    mux4to1 dut (
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .sel(sel),
        .y(y)
    );

    task check;
        input expected;
        begin
            if (y !== expected) begin
                $display("FAIL: sel=%b | d0=%b d1=%b d2=%b d3=%b | y=%b expected=%b",
                          sel, d0, d1, d2, d3, y, expected);
            end else begin
                $display("PASS: sel=%b | y=%b", sel, y);
            end
        end
    endtask

    initial begin
        // Deterministic tests
        d0=0; d1=1; d2=0; d3=1;

        sel=2'b00; #1; check(d0);
        sel=2'b01; #1; check(d1);
        sel=2'b10; #1; check(d2);
        sel=2'b11; #1; check(d3);

        // Random tests
        repeat (10) begin
            d0  = $random;
            d1  = $random;
            d2  = $random;
            d3  = $random;
            sel = $random % 4;
            #1;
            case (sel)
                2'b00: check(d0);
                2'b01: check(d1);
                2'b10: check(d2);
                2'b11: check(d3);
            endcase
        end

        $display("ALL TESTS COMPLETED");
        $finish;
    end

endmodule