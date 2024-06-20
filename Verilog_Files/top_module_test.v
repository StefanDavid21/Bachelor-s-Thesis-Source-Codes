`timescale 1ns / 1ps

module top_module_test
    (
        input clk, 

        output hsynq,
        output vsynq, 
        output [1:0] r,
        output [1:0] g, 
        output [1:0] b 

    );
    
    top_module_vga_screen m1
    (
        .clk(clk), 

        
        .hsynq(hsynq), 
        .vsynq(vsynq), 
        .r(r), 
        .g(g), 
        .b(b)
    );
    
endmodule


