/* Copyright 2024 Grug Huhler.  License SPDX BSD-2-Clause. */

module bad
(
   input wire clk_4_5,
   input wire clk_19_3,
   input wire reset_button,
   output wire [5:0] leds
);

    reg [13:0] counter;
    reg [5:0] leds_reg;

    assign leds = leds_reg;

    /* update a counter in fast clock domain */
    always @(posedge clk_19_3 or negedge reset_button)
       if (~reset_button) begin
          counter <= 14'b0;
       end else begin
          counter <= counter + 14'b1;
       end

    /* Sometimes, read upper bits of counter in slow clock domain.
     * This is fine if changed to fast clock domain */
    always @(posedge clk_4_5 or negedge reset_button)
       if (~reset_button) begin
          leds_reg <= 6'b0;
       end else begin
          if (counter[7:0] == 8'b0) leds_reg <= counter[13:8];
       end

endmodule
