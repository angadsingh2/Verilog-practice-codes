module edge_detector(
    input wire clk,
    input wire signal,
    output reg edge_detected
);
reg prev;
always@(posedge clk) begin 
    edge_detected<= (signal & ~ prev);
    prev<=signal;
end
endmodule