module counter(
    input wire reset,
    input wire clk,
    input wire dir,
    output reg [3:0]count
);
always@(posedge clk or posedge reset) begin
    if (reset) begin
        count<=4'b0000;
    end
    else if (count==4'b1001) begin
        count<=4'b0000;
    end
    else begin
        count<=count+1;
    end
end
endmodule