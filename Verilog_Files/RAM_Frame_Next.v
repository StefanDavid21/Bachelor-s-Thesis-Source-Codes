`timescale 1ns / 1ps

module RAM_Frame_Next
    (
        input wire clk,
        //input wire [18:0] addr_read, // addr_read va fi addr_write - 1 ceea ce va rezulta in ramu celalalt ca la adresa addr write va scrie data write ul de la addre write - 1 ?  
        input wire [18:0] addr_write,
        input wire ram_enable,
        input wire [2:0] data_write,
        output reg [2:0] data_read
           

    );
    
    reg [2:0] effective_memory [0:419999];  // 420k pixeli cu tot cu cei care nu vor fi afisati pe ecran 
    wire clk_25Mhz; 
    
    clk_divider m0
    (
        .clk(clk), 
        .divided_clk(clk_25Mhz)      
    );
    
    always@(posedge clk_25Mhz)
        begin
            data_read = effective_memory[addr_write]; 
        end
    
    always@(posedge clk_25Mhz)
        begin
            if(ram_enable)
                begin
                    effective_memory[addr_write - 1] <= data_write; 
                end    
        end
endmodule
