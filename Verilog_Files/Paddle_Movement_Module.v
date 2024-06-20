`timescale 1ns / 1ps

module Paddle_Movement_Module
    (
        
        input clk, 
        input reset_to_start,
        input stand, 
        input [7:0] ps2_data_out, 
        input [3:0] paddle_movement, 
        
        input [15:0] last_left_paddle_vertical,
        input [15:0] last_right_paddle_vertical,  
        
        output [15:0] left_paddle_vertical, 
        output [15:0] right_paddle_vertical
          
    );
        reg [15:0] reg_left_paddle_vertical;
        reg [15:0] reg_right_paddle_vertical;
    always@(posedge clk) 
        begin   
         
            if(reset_to_start)
                begin
                    reg_left_paddle_vertical <= 300; 
                    reg_right_paddle_vertical <= 300; 
                end
            
            else if(!stand) 
                begin 
                //(last_left_paddle_vertical != 160 || last_left_paddle_vertical != 400) && (last_right_paddle_vertical != 160 || last_right_paddle_vertical != 400)    
                    case(paddle_movement) 
                        4'b1000: begin //R for Left Paddle Up
                                    
                                    if (last_left_paddle_vertical != 160)
                                    begin
                                        reg_left_paddle_vertical <= reg_left_paddle_vertical - 10; 
                                        reg_right_paddle_vertical <= reg_right_paddle_vertical;
                                    end
                                    
                                    else 
                                    begin
                                        reg_left_paddle_vertical <= reg_left_paddle_vertical; 
                                        reg_right_paddle_vertical <= reg_right_paddle_vertical;             
                                    end
                               end
                        
                        4'b0100: begin  //F for Left Paddle Down
                                    
                                    if (last_left_paddle_vertical != 400)
                                    begin
                                        reg_left_paddle_vertical <= reg_left_paddle_vertical + 10; 
                                        reg_right_paddle_vertical <= reg_right_paddle_vertical;
                                    end
                                    
                                    else 
                                    begin
                                        reg_left_paddle_vertical <= reg_left_paddle_vertical; 
                                        reg_right_paddle_vertical <= reg_right_paddle_vertical;             
                                    end                                
                               end        
                        
                        4'b0010: begin  //Y for Right Paddle Up 
                                    
                                    if (last_right_paddle_vertical != 160)
                                    begin
                                        reg_left_paddle_vertical <= reg_left_paddle_vertical; 
                                        reg_right_paddle_vertical <= reg_right_paddle_vertical - 10;
                                    end
                                    
                                    else 
                                    begin
                                        reg_left_paddle_vertical <= reg_left_paddle_vertical; 
                                        reg_right_paddle_vertical <= reg_right_paddle_vertical;             
                                    end
                               end
                        
                        4'b0001: begin //H for Right Paddle Down 
                                    
                                    if (last_right_paddle_vertical != 400)
                                    begin
                                        reg_left_paddle_vertical <= reg_left_paddle_vertical; 
                                        reg_right_paddle_vertical <= reg_right_paddle_vertical + 10;
                                    end
                                    
                                    else 
                                    begin
                                        reg_left_paddle_vertical <= reg_left_paddle_vertical; 
                                        reg_right_paddle_vertical <= reg_right_paddle_vertical;             
                                    end
                               end
                        
                        default: begin 
                                        reg_left_paddle_vertical <= reg_left_paddle_vertical; 
                                        reg_right_paddle_vertical <= reg_right_paddle_vertical;
                                    
                                 end    
                    endcase                
                end
            
            else 
                begin
                        reg_left_paddle_vertical <= reg_left_paddle_vertical;  
                        reg_right_paddle_vertical <= reg_right_paddle_vertical;
                end    
            
        end 
        
        
assign left_paddle_vertical = reg_left_paddle_vertical; 
assign right_paddle_vertical = reg_right_paddle_vertical;         

endmodule
