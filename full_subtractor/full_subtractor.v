module full_subtractor(
    input wire a, 
    input wire b,
    input wire bin,
    output wire diff, 
    output wire borrow
); 
assign diff = a^b^bin;
assign borrow= (~a & b)| (~a& bin )|(b & bin);
endmodule