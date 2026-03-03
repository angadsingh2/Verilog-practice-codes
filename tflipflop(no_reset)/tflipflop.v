module tflipflop(
    input wire t,
    input wire clk,
    output reg q
);
always @(posedge clk) begin 
    if (t) begin 
        q<=~q;
    end
    else begin 
        q<=q;
    end
end
endmodule