`timescale 1ns / 1ps

module led_forward #(parameter STEP=1)(
    input wire clk,
	 input wire rst,
	 input wire en,
	 output reg [3:0] leds,
	 output reg done
	 );
reg [1:0] index;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		index<=0;
		leds<=4'b0001;
		done<=0;
	end else if (!en) begin 
	  index <= 0;
	  leds  <= 4'b0001;
	  done  <= 0;
	end else if(en &&!done) begin
		index<=(index+STEP >=3)?3:index+STEP;
		leds<=4'b0001<<index;
		done<=(index==3);
	end
end

endmodule
        