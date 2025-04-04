`timescale 1ns / 1ps

module fir_filter(clk,rst,x_in,y_out);
input clk;
input rst;
input [15:0] x_in;
output reg [31:0] y_out;

parameter signed [15:0] h0 = 16'd1, 
                        h1 = 16'd2, 
                        h2 = 16'd3, 
                        h3 = 16'd4;
    
    reg signed [15:0] x [0:3];
    integer i;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 4; i = i + 1)
                x[i] <= 16'd0;
            y_out <= 32'd0;
        end else begin
            // Shift inputs
            x[3] <= x[2];
            x[2] <= x[1];
            x[1] <= x[0];
            x[0] <= x_in;
            
            y_out <= (x[0] * h0) + (x[1] * h1) + (x[2] * h2) + (x[3] * h3); // FIR filter computation
        end
    end
endmodule
