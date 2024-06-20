`timescale 1ns / 1ps


module LFSR_Height(
    
    input clk,
    input reset,
    input is_active,
    output reg [15:0] random_number
);

reg [9:0] lfsr = 150;

always @(posedge clk) begin
    
    if(reset || (lfsr == 0))  
        
            lfsr <= lfsr + 75;
     
    else if (is_active)
        begin
            // XOR the taps for the LFSR
            lfsr[9] <= lfsr[9] ^ lfsr[5] ^ lfsr[3] ^ lfsr[2];
            lfsr[8:0] <= lfsr[9:1];
        end
end

always @(posedge clk) begin
    if(reset) 
        random_number <= 0; 
    else
        if(is_active)    
            
            random_number <= ((lfsr % ((440 - 220 + 1) / 10 + 1)) * 10) + 220;
            
        else
            random_number <= random_number;     
end
endmodule
