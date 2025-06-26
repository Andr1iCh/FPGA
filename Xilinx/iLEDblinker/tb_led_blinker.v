`timescale 1ns / 1ps

module tb_led_blinker_top;

    parameter STEP = 1;

    reg clk;
    reg rst;
    wire [3:0] leds;

    led_blinker_top #(.STEP(STEP)) uut (
        .clk(clk),
        .rst(rst),
        .leds(leds)
    );

    always begin
        clk = 1; #5;
        clk = 0; #5;
    end

    initial begin
        rst = 1;
        #20;
        rst = 0;
        #500;
        $stop;
    end

endmodule