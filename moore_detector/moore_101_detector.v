module moore_101_detector(
    input wire clk,
    input wire reset,
    input wire x,
    output reg y
);
parameter s0=2'b00, s1= 2'b01, s2=2'b10,s3=2'b11;
reg [1:0] present_state, next_state;
always @(posedge clk or posedge reset) begin 
    if (reset) begin 
        present_state<= s0 ; 
    end
    else begin 
        present_state<= next_state;
    end
end

always@(*) begin
    case(present_state)
    s0: begin
        if (x) next_state=s1;
        else next_state= s0; 
    end
    s1: begin
        if (x) next_state= s1;
        else next_state= s2;
    end
    s2: begin 
        if (x) next_state= s3;
        else next_state=s0 ; 
    end
    s3: begin
        if (x) next_state=s1;
        else next_state =s2; 
    end
     
    endcase
end

always@(*) begin 
    if (present_state==s3) begin 
        y=1; 
    end
    else 
    y=0; 
end

endmodule
