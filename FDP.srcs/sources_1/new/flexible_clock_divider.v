`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2025 15:23:51
// Design Name: 
// Module Name: flexible_clock_divider
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


module flexible_clock_divider(input clock, input [31:0] m, output reg new_clock = 0);

reg [31:0] count = 0;

always @ (posedge clock) begin
    count <= (count == m) ? 0 : count + 1;
    new_clock <= (count == 0) ? ~new_clock : new_clock; 
end

endmodule
