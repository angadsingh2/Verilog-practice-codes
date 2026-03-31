'timescale 1ns/1ps
module tb();
reg clk , reset, x;
wire y;

moore_101_detector uut( .clk(clk), .reset(reset), .x(x), .y(y));
always #5 clk = ~clk;
initial 
begin 
clk=0;
reset=1;
x=0;

#10 reset=0;

#10 x=0;
#10 x=1;
#10 x=0;
#10 x=1;
#10 x=0;
#10 x=1;

#20 $finish;
end
initial begin
    $monitor("Time=%0t | x=%b | y=%b", $time, x, y);
end

endmodule