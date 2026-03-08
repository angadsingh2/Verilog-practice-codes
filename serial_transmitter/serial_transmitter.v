module serial_tx #(
    parameter DATA_WIDTH = 8
)(
    input  wire clk,
    input  wire reset,
    input  wire start,
    input  wire [DATA_WIDTH-1:0] data_in,

    output reg  tx,
    output reg  busy,
    output reg  done
);

reg [DATA_WIDTH-1:0] shift_reg;
reg [$clog2(DATA_WIDTH):0] bit_count;

localparam IDLE  = 2'b00;
localparam LOAD  = 2'b01;
localparam SHIFT = 2'b10;
localparam DONE  = 2'b11;

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state     <= IDLE;
        tx        <= 1'b1;
        busy      <= 0;
        done      <= 0;
        bit_count <= 0;
        shift_reg <= 0;
    end
    else begin
        case (state)

        IDLE: begin
            done <= 0;
            busy <= 0;
            tx   <= 1'b1;

            if (start)
                state <= LOAD;
        end

        LOAD: begin
            shift_reg <= data_in;
            bit_count <= 0;
            busy      <= 1;
            state     <= SHIFT;
        end

        SHIFT: begin
            tx <= shift_reg[0];
            shift_reg <= shift_reg >> 1;
            bit_count <= bit_count + 1;

            if (bit_count == DATA_WIDTH-1)
                state <= DONE;
        end

        DONE: begin
            busy <= 0;
            done <= 1;
            tx   <= 1'b1;
            state <= IDLE;
        end

        endcase
    end
end

endmodule