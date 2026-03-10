module moore_machine(
    input wire clk,
    input wire reset,
    input wire din,
    output reg detected
);
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011 , s4=3'b100;
reg [2:0] current_state, next_state;
always@ (posedge clk or posedge reset) begin
    if(reset) current_state<=s0;
    else current_state<=next_state;
end
always@(*) begin
    case(current_state)
    s0: next_state= din ?s1:s0;
    s1: next_state =din ?s2:s1;
    s2: next_state =din ?s3:s2;
    s3: next_state =din ?s4:s3;
    s4: next_state =din ?s1:s2;
    default:next_state =s0;
    endcase
end
always @(*) begin
        detected = (current_state == s4) ? 1'b1 : 1'b0;
    end
endmodule