`timescale 1ns / 1ps

module video_2
    (
        input clk,
        input sw1,
        input sw2,
        input sw3, 

        output hsynq, 
        output vsynq, 
        output [3:0] r, 
        output [3:0] g, 
        output [3:0] b
    );
    
    wire clk_25Mhz;
    wire enable_v_counter; 
    wire [15:0] h_count_value; 
    wire [15:0] v_count_value; 
    
    clk_divider m0
    (
        .clk(clk), 
        .divided_clk(clk_25Mhz)      
    );
    
    horizontal_counter m1
    (
        .clk_25Mhz(clk_25Mhz), 
        .enable_v_counter(enable_v_counter), 
        .h_count_value(h_count_value)

    );
    
    vertical_counter m2
    (
        .clk_25Mhz(clk_25Mhz), 
        .enable_v_counter(enable_v_counter), 
        .v_count_value(v_count_value)

    );
    
//outputs 
assign hsynq = (h_count_value < 96) ? 1'b0 : 1'b1; 
assign vsynq = (v_count_value < 2)  ? 1'b0 : 1'b1; 

//colors - all colors high = white screen 
assign r = (h_count_value > 143 && h_count_value < 784 && v_count_value > 34 && v_count_value < 515 && (sw1)) ? 4'hF : 4'h0;
assign g = (h_count_value > 143 && h_count_value < 784 && v_count_value > 34 && v_count_value < 515 && (sw2)) ? 4'hF : 4'h0; 
assign b = (h_count_value > 143 && h_count_value < 784 && v_count_value > 34 && v_count_value < 515 && (sw3)) ? 4'hF : 4'h0;      
 
    
endmodule
