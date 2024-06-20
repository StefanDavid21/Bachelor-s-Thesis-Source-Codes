`timescale 1ns / 1ps

module vertical_counter
    (
        input clk_25Mhz, 
        input enable_v_counter, 
        output reg [15:0] v_count_value = 0

    );
    
    always@(posedge clk_25Mhz)
     begin 
     if(enable_v_counter) 
     begin   
        if(v_count_value < 524) 
            begin
                v_count_value <=  v_count_value + 1; 
            end
        else 
            begin
                v_count_value <= 0; 
            end
     end       
     end               
endmodule
