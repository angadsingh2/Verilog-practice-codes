module halfadder (
    input  wire a,
    input  wire b,
    output wire adder,
    output wire carry
);
assign adder = a^ b;
assign carry = a & b ;
endmodule;