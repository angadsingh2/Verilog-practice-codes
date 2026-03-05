module ring_counter(
    input wire clk,
    input wire reset,
    output reg [3:0] count
);

always @(posedge clk or posedge reset) begin
    if (reset)
        count <= 4'b1000;           
    else
        count <= {count[0], count[3:1]};  
end

endmodule

