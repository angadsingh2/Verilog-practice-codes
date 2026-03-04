module sr_latch(
    input  wire s,
    input  wire r,
    output reg  q
);

    always @(*) begin
        if (s && !r)
            q = 1'b1;
        else if (!s && r)
            q = 1'b0;
        else if (!s && !r)
            q = q;       
        else
            q = 1'bx;     
    end

endmodule