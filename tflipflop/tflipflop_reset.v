module tflipflop_reset(
    input wire reset,
    input wire t,
    input wire clk,
    output reg q
);
    always @(posedge clk or posedge reset) begin 
        if (reset) begin 
            q<=1'b0;
        end
        else begin 
            if (t) begin 
                q<=~q;
            end
            else begin 
                q<=q;
            end 
        end 
    end
endmodule