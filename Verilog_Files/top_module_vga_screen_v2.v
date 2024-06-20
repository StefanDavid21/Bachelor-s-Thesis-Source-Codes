`timescale 1ns / 1ps

module top_module_vga_screen_v2
    (
        input clk, 
        input [18:0] address_in,
        input [11:0] data_in,
        
        output hsynq, 
        output vsynq, 
        output reg [11:0] data_out
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
always@(posedge clk_25Mhz)
        begin
            data_out <= data_in; 
          /*  
            if(((v_count_value * 800 + h_count_value) - 8000) == address_in)
                begin
                    data_out <= data_in; 
                end
            else
                begin
                    data_out <= 3'b000; 
                end*/
        end 

// Timp de revenire de la un frame la altul: (35 + 10)*800 = 36.000 clk cycles     
endmodule
