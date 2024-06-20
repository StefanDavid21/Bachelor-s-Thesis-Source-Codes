`timescale 1ns / 1ps

module addr_read_counter
    (
        input [18:0] addr_write, 
        input [18:0] constant,
        
        output[18:0] addr_read
    );
    
    assign addr_read = addr_write - constant; 
    
endmodule
