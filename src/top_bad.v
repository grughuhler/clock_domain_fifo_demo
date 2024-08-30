/* Copyright 2024 Grug Huhler.  License SPDX BSD-2-Clause. */

module top
(
   input wire clk_in_27,
   input wire reset_button,
   output wire [5:0] leds
);

    wire clk_19_3;
    wire clk_4_5;
    reg [29:0] counter;
    reg [5:0] leds_reg;

    assign leds = ~leds_reg;

    /* update a counter in fast clock domain */
    always @(posedge clk_19_3 or negedge reset_button)
       if (~reset_button) begin
          counter <= 30'b0;
       end else begin
          counter <= counter + 30'b1;
       end

    /* Sometimes, read upper bits of counter in slow clock domain. */
    always @(posedge clk_4_5 or negedge reset_button)
       if (~reset_button) begin
          leds_reg <= 6'b0;
       end else begin
          if (counter[23:0] == 24'b0) leds_reg <= counter[29:24];
       end

    /* Create 4.5 MHz clock */
    Gowin_rPLL_4_5 slow_clock (
        .clkout(clk_4_5),
        .clkin(clk_in_27)
    );

    /* Create 19.285714 MHz clock */
    Gowin_rPLL_19_3 faster_clock  (
        .clkout(clk_19_3),
        .clkin(clk_in_27)
    );

endmodule
