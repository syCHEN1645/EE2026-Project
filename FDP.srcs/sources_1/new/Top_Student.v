`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: Khor Hsien Kit
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (input basys_clock, sw4, output [7:0] JXADC);
    wire clk_6p25Mhz;
    wire clk_25Mhz;
    
    wire fb; 
    wire sending_pixels;
    wire sample_pixel;
    wire [12:0] pixel_index;
    wire [7:0] x;
    wire [6:0] y;
    assign x = pixel_index % 96;
    assign y  = pixel_index / 96;
    
    parameter [15:0] red = 16'b11111_000000_00000;
    parameter [15:0] green = 16'b00000_111111_00000;
    
//    reg [15:0] oled_data = (SW[4] == 1) ? red : green;
    reg [15:0] oled_data;
    
    always @ (posedge clk_25Mhz) begin
        if (x > 30 && x < 50 && y > 30 && y < 50) begin
            oled_data = red;
        end
        else begin
            oled_data = green;
        end
    end
    
    flexible_clock_divider clock_6p25MHz (basys_clock, 7, clk_6p25Mhz);
    flexible_clock_divider clock_25Mhz (basys_clock, 1, clk_25Mhz);
    
    Oled_Display oled_unit_B (
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