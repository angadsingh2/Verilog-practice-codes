module universal_shift_register #(
    parameter N = 4
)(
    input  wire clk,
    input  wire reset,
    input  wire [1:0] mode, 
    input  wire serial_left,       
    input  wire serial_right,      
    input  wire [N-1:0] data_in,  
    output reg  [N-1:0] data_out   
);
always @(posedge clk or posedge reset) begin
    if (reset)
        data_out <= {N{1'b0}};
    else begin
        case (mode)
            2'b00:data_out <= data_out;
            2'b01:data_out <= {serial_right, data_out[N-1:1]};
            2'b10:data_out <= {data_out[N-2:0], serial_left};
            2'b11:data_out <= data_in;
        endcase
    end
end
endmodule