`timescale 1ns / 1ps

module led_blinker_top #(parameter STEP=1)(
    input wire clk,
	 input wire rst,
	 output wire [3:0] leds
	 );
reg direction; // 1 - forward 0 - backward
wire[3:0] leds_fwd, leds_bwd;
wire done_fwd,done_bwd;

led_forward #(.STEP(STEP)) FWD (
        .clk(clk), .rst(rst), .en(direction),
        .leds(leds_fwd), .done(done_fwd)
    );
led_backward #(.STEP(STEP)) BWD (
        .clk(clk), .rst(rst), .en(~direction),
        .leds(leds_bwd), .done(done_bwd)
    );	 
 assign leds = direction ? leds_fwd : leds_bwd;
 always @(posedge clk or posedge rst) begin
        if (rst)          
			direction <= 1;
        else if (direction && done_fwd) 
			direction <= 0;
        else if (~direction && done_bwd) 
			direction <= 1;
    end
endmodule
