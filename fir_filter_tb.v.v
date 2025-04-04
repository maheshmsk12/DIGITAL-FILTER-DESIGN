`timescale 1ns / 1ps

module fir_filter_tb;

    reg clk, rst;
    reg signed [15:0] x_in;
    wire signed [31:0] y_out;
    
    // Instantiate FIR filter
    fir_filter uut (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),
        .y_out(y_out)
    );
    
    // Clock generation
    always #5 clk = ~clk;  // 10ns period

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        x_in = 0;
        #10 rst = 0;  // Release reset

        // Apply test samples
        #10 x_in = 16'd10;
        #10 x_in = 16'd20;
        #10 x_in = 16'd30;
        #10 x_in = 16'd40;
        #10 x_in = 16'd50;
        #10 x_in = 16'd60;
        #50 $stop;
    end

endmodule
