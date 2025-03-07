`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2025 10:39:29 PM
// Design Name: 
// Module Name: Debouncer
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


module Debouncer(
    input clk, btn,
    output stable
    );
    wire q;
    // 2-stage debouncer
    DFF dff1(clk, btn, q);
    DFF dff2(clk, q, stable);
endmodule

module DFF(
    input clk, d,
    output reg q
    );

    always @ (posedge clk) begin
        q <= d;
    end
endmodule