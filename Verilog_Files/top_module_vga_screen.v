`timescale 1ns / 1ps

module top_module_vga_screen
    (
        input clk, 

        output hsynq, 
        output vsynq, 
        output [15:0] haddress, 
        output [15:0] vaddress
        
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

assign haddress = h_count_value;   
assign vaddress = v_count_value; 
 
    
endmodule
