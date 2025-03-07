`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2025 10:02:13 PM
// Design Name: 
// Module Name: Task_D
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Task_D(
    input basys_clock, btnC, btnU, btnL, btnR, btnD,
    output [7:0] JXADC
    );
    
    wire clk_1p5Mhz;
    wire clk_6p25Mhz;
    wire fb; 
    wire sending_pixels;
    wire sample_pixel;
    wire [12:0] pixel_index;
    reg [15:0] oled_data;
    
    flexible_clock_divider clock_6p25Mhz (basys_clock, 7, clk_6p25Mhz);
    flexible_clock_divider clock_1p5khz (basys_clock, 4095, clk_1p5Mhz);
    
    Oled_Display oled_unit_D (
        .clk(clk_6p25Mhz),
        .reset(0),
        .frame_begin(fb), 
        .sending_pixels(sending_pixels),
        .sample_pixel(sample_pixel),
        .pixel_index(pixel_index),
        .pixel_data(oled_data),
        .cs(JXADC[0]),
        .sdin(JXADC[1]),
        .sclk(JXADC[3]),
        .d_cn(JXADC[4]),
        .resn(JXADC[5]), 
        .vccen(JXADC[6]),
        .pmoden(JXADC[7])
    );
    
    always@ (posedge clk_1p5Mhz) begin
    
    end
endmodule
