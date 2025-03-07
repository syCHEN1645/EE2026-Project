`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2025 11:16:58 PM
// Design Name: 
// Module Name: debouncer_test
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


module debouncer_test(

    );
    reg btn = 0;
    reg q = 0;
    reg s = 0;
    reg clk = 0;
    
    always begin
        btn = 1; #1000;
        btn = 0; #50;
        btn = 1; #50;
        btn = 0; #50;
        btn = 1; #50;
        btn = 0; #20;
        btn = 1; #20;
        btn = 0; #20;
        btn = 1; #20;
        btn = 0; #20;
        btn = 1; #20;
        btn = 0; #5000;
    end
    
    always begin
        clk = ~clk; #782;
    end
    
    always @ (clk) begin
        q <= btn;
        s <= q;
    end
endmodule
