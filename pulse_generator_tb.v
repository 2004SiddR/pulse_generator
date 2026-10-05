`timescale 1ns / 1ps
module tb;
reg clk, reset;
wire [3:0] q; // Changed from reg to wire
wire pulse;

  pulse_gen DUT (clk, reset, q, pulse);

  initial begin
        clk     = 0;
         reset  = 1;
     #11 reset  = 0;
     #1000 $stop;
  end
  
  always #10 clk = ~clk; // T=20 ns, f= 50 Mhz
  
  initial 
    begin       // waveform generation code 
      $dumpfile("dump.vcd");
      $dumpvars;         
   end
endmodule