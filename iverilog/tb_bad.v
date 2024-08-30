/* Copyright 2024 Grug Huhler.  License SPDX BSD-2-Clause. */

`timescale 1ns/100ps

module tb_bad;

   localparam clk_4_5_period = 111.11111; // 4.5 MHz
   localparam clk_19_3_period = 25.925926; // 19.285714 MHz

   wire [5:0] leds;
   reg clk_4_5;
   reg clk_19_3;
   reg reset_button;
   
   bad bad0
     (
      .clk_4_5(clk_4_5),
      .clk_19_3(clk_19_3),
      .reset_button(reset_button),
      .leds(leds)
      );

   initial
     begin
        $display("starting");
        $dumpfile("waveform.vcd");
        $dumpvars(3, tb_bad);
        reset_button = 1;
        clk_4_5 = 1;
        clk_19_3 = 1;
     end

   initial
     begin
        forever  #clk_4_5_period clk_4_5 = ~clk_4_5;
     end

   initial
     begin
        forever  #clk_19_3_period clk_19_3 = ~clk_19_3;
     end

   initial
     begin
        @(posedge clk_4_5) reset_button = 0;
        @(posedge clk_4_5) reset_button = 1;

        repeat (3000) @(posedge clk_4_5);
        $finish;
     end

endmodule
