`timescale 1ns / 1ps

module led_backward#(parameter STEP=1)(
input wire clk,
input wire rst,
input wire en,
output reg[3:0] leds,
output reg done
    );
reg [1:0] index;

always @(posedge clk or posedge rst) begin
	if(rst)begin
		index <= 3;
		leds  <= 4'b1000;
		done<=0;
	end else if (!en) begin
	  index <= 3;
	  leds  <= 4'b1000;
	  done  <= 0;
	end else if (en&&!done)begin
		index<=(index<=STEP)?0:index-STEP;
		leds <= 4'b0001 << index;
		done<=(index==0);
	end
end


endmodule
