`timescale 1ns / 1ps

module clk_divider_5Hz
    (
        input clk, //100Mhz
        output reg divided_clk = 0      
    );
    
    integer counter_value = 0; // 32 bit wide reg bus
    
// division_value = 100Mhz / (2*desired Frequency) - 1 => 25MHz => 2
    localparam division_value = 11111111; 
    
 
//counter     
    always@ (posedge clk)
        begin 
            if(counter_value == division_value) 
                counter_value <= 1; 
            else
                counter_value <= counter_value + 1 ;     
        end

//divide clock     
    always@(posedge clk)
        begin 
            if (counter_value == division_value) 
                divided_clk <= ~divided_clk;  
            else 
                divided_clk <= divided_clk;     
                
        end           
    
endmodule
