`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2025 15:24:42
// Design Name: 
// Module Name: flexible_clock_divider_sim
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


module flexible_clock_divider_sim();
    reg sim_clock;
    reg [31:0] sim_m;
    wire sim_slow_clock;
    
    flexible_clock_divider dut (sim_clock, sim_m, sim_slow_clock);
    
    initial begin
        sim_clock = 0;
        sim_m = 32'd7;
    end
    
    always begin
        #5; sim_clock = ~sim_clock;
    end
    
endmodule
