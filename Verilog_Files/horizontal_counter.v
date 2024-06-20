`timescale 1ns / 1ps

module horizontal_counter
    (
        input clk_25Mhz, 
        output reg enable_v_counter = 0, 
        output reg [15:0] h_count_value = 0

    );
    
    always@(posedge clk_25Mhz)
     begin 
        if(h_count_value < 799) 
            begin
                h_count_value <=  h_count_value + 1; 
                enable_v_counter <= 0; //disable vertical counter 
            end
        else 
            begin
                h_count_value <= 0; // reset horizontal counter
                enable_v_counter <= 1; 
            end
            
     end               
endmodule
