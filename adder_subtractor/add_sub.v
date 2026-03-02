module add_sub #(
    parameter N = 8
)(
    input  wire [N-1:0] A,
    input  wire [N-1:0] B,
    input  wire         sub,      
    output wire [N-1:0] result,
    output wire         cout,
    output wire         overflow
);
    wire [N-1:0] B_modified;
    wire [N:0]   carry;
    assign carry[0] = sub;
    assign B_modified = B ^ {N{sub}};

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : ripple
            full_adder fa (
                .a   (A[i]),
                .b   (B_modified[i]),
                .cin (carry[i]),
                .sum (result[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    assign cout = carry[N];
    assign overflow = carry[N] ^ carry[N-1];

endmodule