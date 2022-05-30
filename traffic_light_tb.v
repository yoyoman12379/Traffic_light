`timescale	10ns/100ps
`include "./traffic_light.v"
`include "tsmc13.v"

module tb();

wire [1:0] LightA, LightB;
reg clk, reset;

traffic_light UUT(LightA, LightB, clk, reset);

initial begin
$monitor($time, "   LightA=%b, LightB=%b, clk=%b, reset=%b," ,LightA, LightB, clk, reset);

end

initial begin
$fsdbDumpfile("wave.fsdb");
$fsdbDumpvars;
end


endmodule