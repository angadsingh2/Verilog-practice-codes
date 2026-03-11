module mealy_machine (
    input clk,
    input reset,
    input din,
    output reg dout
);
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] current_state, next_state;
    always @(posedge clk or posedge reset) begin
        if (reset) current_state <= S0;
        else current_state <= next_state;
    end

    always @(*) begin
        dout = 1'b0; 
        case (current_state)
            S0: next_state = din ? S1 : S0;
            S1: next_state = din ? S1 : S2;
            S2: next_state = din ? S3 : S0;
            S3: begin
                if (din) begin
                    next_state = S1;
                    dout = 1'b1; 
                end else begin
                    next_state = S2;
                    dout = 1'b0;
                end
            end
            default: next_state = S0;
        endcase
    end
endmodule
