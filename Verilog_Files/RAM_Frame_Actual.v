`timescale 1ns / 1ps


module RAM_Frame_Actual
    (
        input wire clk,
        input wire [18:0] addr_read,  
        input wire [18:0] addr_write,
        input wire ram_enable,
        input wire [11:0] data_write,
        output reg [11:0] data_read
           

    );
    
    reg [11:0] effective_memory [0:419999];  // 420k pixeli cu tot cu cei care nu vor fi afisati pe ecran 
    
    /*wire clk_25Mhz; 
    
    clk_divider m0
    (
        .clk(clk), 
        .divided_clk(clk_25Mhz)      
    );*/
        
    always@(posedge clk)
        begin
            if((addr_read >= 28000) && (addr_read <= 411999))
                begin
                    data_read = effective_memory[addr_read];
                end                     
        end
    
    always@(posedge clk)
        begin
            if(ram_enable)
                begin
                    effective_memory[addr_write] <= data_write; 
                end    
        end
endmodule
