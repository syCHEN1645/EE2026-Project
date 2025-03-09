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
    
    wire clk_1p5khz;
    wire clk_6p25Mhz;
    wire clk_30hz;
    wire fb; 
    wire sending_pixels;
    wire sample_pixel;
    wire [12:0] pixel_index;
    reg [15:0] oled_data;
    
    // clocks
    // for oled
    flexible_clock_divider clock_6p25Mhz (basys_clock, 7, clk_6p25Mhz);
    // for button
    flexible_clock_divider clock_1p5khz (basys_clock, 65536, clk_1p5khz);
    // for movement speed
    flexible_clock_divider clock_30hz (basys_clock, 1666667, clk_30hz);

    
    // debounced buttons
    wire stableU, stableL, stableR, stableD;
    Debouncer db1 (clk_1p5khz, btnU, stableU);
    Debouncer db2 (clk_1p5khz, btnL, stableL);
    Debouncer db3 (clk_1p5khz, btnR, stableR);
    Debouncer db4 (clk_1p5khz, btnD, stableD);
    
    parameter left_bound = 7'd0;
    parameter top_bound = 6'd0;
    parameter right_bound = 7'd95;
    parameter bottom_bound = 6'd63;
    
    parameter green_len = 10;
    parameter red_len = 30;
    parameter speed = 30;
    
    parameter red = 16'b11111_000000_00000;
    parameter green = 16'b00000_111111_00000;
    parameter blue = 16'b00000_000000_11111;
    parameter black = 16'b0;
    wire [6:0] x;
    wire [7:0] y;
    
    // 4 sides of green square
    reg [6:0] green_top = bottom_bound - green_len + 1;
    reg [6:0] green_bottom = bottom_bound;
    reg [7:0] green_left = left_bound;
    reg [7:0] green_right = left_bound + green_len - 1;
    
    // 4 sides of red square
    reg [6:0] red_top = top_bound;
    reg [6:0] red_bottom = top_bound + red_len - 1;
    reg [7:0] red_left = right_bound - red_len + 1;
    reg [7:0] red_right = right_bound;
    
    // dir: L = 1; R = 2; U = 3; D = 4; N = 0;
    reg [2:0] dir = 0;
    
    // x is row (0~63)
    // y is column (0~95)
    assign x = pixel_index / 96;
    assign y = pixel_index % 96;
    
    // listen to button press
    // refresh display
    always@ (posedge clk_6p25Mhz) begin
        // refresh display
        // red square
        if (x >= red_top && x <= red_bottom
            && y <= red_right && y >= red_left)
            oled_data = red;
        // green square
        else if (x >= green_top && x <= green_bottom
            && y >= green_left && y <= green_right)
            oled_data = green;
        // black background
        else
            oled_data = black;
    end
        
    always@ (posedge clk_1p5khz) begin
        // listen to button press
        if (stableL == 1)
            dir = 1;
        else if (stableR == 1)
            dir = 2;
        else if (stableU == 1)
            dir = 3;
        else if (stableD == 1)
            dir = 4;
    end
    
    // green square move according to dir
    always@ (posedge clk_30hz) begin
        if (dir == 1) begin
            // move left, check collision
            if (green_left != left_bound) begin
                // no collision with left bound
                // move left by 1
                green_left = green_left - 1;
                green_right = green_right - 1;
            end
        end
        else if (dir == 2) begin
            // move right, check collision
            if (green_right != right_bound) begin
                // no collision with right bound
                if (green_bottom < red_top
                    || green_top > red_bottom
                    // not aligned with red square
                    || green_right != red_left - 1
                    // not touching red sqaure
                    ) begin
                    green_left = green_left + 1;
                    green_right = green_right + 1;
                end
            end
        end
        else if (dir == 3) begin
            // move up, check collision
            if (green_top != top_bound) begin
                // no collision with top bound
                if (green_left > red_right
                    || green_right < red_left
                    // not aligned with red square
                    || green_top != red_bottom + 1
                    // not touching red square
                    ) begin
                    green_top = green_top - 1;
                    green_bottom = green_bottom - 1;
                end
            end
        end 
        else if (dir == 4) begin
            // move down, check collision
            if (green_bottom != bottom_bound) begin
                // no collision with bottom bound
                green_top = green_top + 1;
                green_bottom = green_bottom + 1;
            end
        end
    end
        
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
    
endmodule
