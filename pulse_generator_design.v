`timescale 1ns / 1ps
module pulse_gen(clk, reset, q, pulse);
input clk, reset;
output reg [3:0] q;
output wire pulse;

wire [3:0] q_next;

assign q_next = (q == 10) ? 4'd0 : q + 4'd1;  
assign pulse = (q == 10) ? 1'b1 : 1'b0;  

always @ (posedge clk) begin
    if (reset)
        q <= 4'd0;
    else
        q <= q_next;
end
		
endmodule