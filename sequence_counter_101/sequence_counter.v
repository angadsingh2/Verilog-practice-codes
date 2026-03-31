module sequence_counter(
    input wire clk,
    input wire reset,
    input wire din,
    output reg [3:0] count
);
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
reg [1:0] state, next_state;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
        count <= 4'b0000;
    end
    else begin
        state <= next_state;
        if (state == S2 && din == 1)
            count <= count + 1;
    end
end

always @(*) begin
    case (state)
        S0: next_state = din ? S1 : S0;
        S1: next_state = din ? S1 : S2;
        S2: next_state = din ? S1 : S0;
        default: next_state = S0;

    endcase
end
endmodule