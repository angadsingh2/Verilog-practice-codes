module mealy_101_detector (
    input clk,
    input reset,
    input x,
    output reg y
);
    
parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10;

reg [1:0] state, next_state;
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end
always @(*) begin
    case(state)
    
        S0: begin
            if (x) begin
                next_state = S1;
                y = 0;
            end else begin
                next_state = S0;
                y = 0;
            end
        end
        
        S1: begin
            if (x) begin
                next_state = S1;
                y = 0;
            end else begin
                next_state = S2;
                y = 0;
            end
        end
        
        S2: begin
            if (x) begin
                next_state = S1;
                y = 1; 
            end else begin
                next_state = S0;
                y = 0;
            end
        end
        
        default: begin
            next_state = S0;
            y = 0;
        end
    endcase
end

endmodule