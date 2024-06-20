`timescale 1ns / 1ps
module Ball_Direction_Change_Module
    (
        input clk, 
        input reset_to_start,  
        input stand, 
        input [3:0] direction, 
        
        input [15:0] left_paddle_coord_vertical, 
        //input [15:0] left_paddle_coord_horizontal, 
        input [15:0] right_paddle_coord_vertical, 
        //input [15:0] right_paddle_coord_horizontal,
        
        input [15:0] ball_coord_horizontal, 
        input [15:0] ball_coord_vertical,
        
        
        output [3:0] new_direction, 
        output stand_out,
        output isactive_in_player_1, 
        output isactive_in_player_2 
    );
        reg [3:0] reg_new_direction; 
        reg reg_stand; 
        reg reg_isactive_in_player_1, prev_reg_isactive_in_player_1; 
        reg reg_isactive_in_player_2, prev_reg_isactive_in_player_2; 
        
    always@(posedge clk) 
        
        if(reset_to_start)       
            begin
                reg_new_direction <= 3;
                reg_stand <= 0;    
            end       
     
        else if(!stand) 
            begin
  
                if(ball_coord_vertical == 165 && ball_coord_horizontal >= 220 && ball_coord_horizontal <= 705) //Collision with Upper Border
                    begin
                        if(direction >= 1 && direction <= 5) //Coming From Left
                            reg_new_direction <= 5; 
                        else if (direction >= 6 && direction <= 10) //Coming From Right
                            reg_new_direction <= 6;      
                    end 
                
                else if(ball_coord_vertical == 440 && ball_coord_horizontal >= 220 && ball_coord_horizontal <= 705) //Collision with Down Border 
                    begin
                        if(direction >= 1 && direction <= 5) //Coming From Left       
                            reg_new_direction <= 1;                
                        else if (direction >= 6 && direction <= 10) //Coming From Right
                            reg_new_direction <= 10;                
                    end
                
                // Left Paddle Collision 
                else if(ball_coord_horizontal == 255 && ball_coord_vertical >= left_paddle_coord_vertical && ball_coord_vertical <= left_paddle_coord_vertical + 10) 
                            
                            reg_new_direction <= 1;
                else if(ball_coord_horizontal == 255 && ball_coord_vertical >= left_paddle_coord_vertical + 10 && ball_coord_vertical <= left_paddle_coord_vertical + 20) 
                            
                            reg_new_direction <= 2;             
                else if(ball_coord_horizontal == 255 && ball_coord_vertical >= left_paddle_coord_vertical + 20 && ball_coord_vertical <= left_paddle_coord_vertical + 30) 
                            
                            reg_new_direction <= 3;
                else if(ball_coord_horizontal == 255 && ball_coord_vertical >= left_paddle_coord_vertical + 30 && ball_coord_vertical <= left_paddle_coord_vertical + 40) 
                            
                            reg_new_direction <= 4;
                else if(ball_coord_horizontal == 255 && ball_coord_vertical >= left_paddle_coord_vertical + 40 && ball_coord_vertical <= left_paddle_coord_vertical + 50) 
                            
                            reg_new_direction <= 5;
                            
                // Right Paddle Collision            
                else if(ball_coord_horizontal == 670 && ball_coord_vertical >= right_paddle_coord_vertical && ball_coord_vertical <= right_paddle_coord_vertical + 10) 
                            
                            reg_new_direction <= 10;
                else if(ball_coord_horizontal == 670 && ball_coord_vertical >= right_paddle_coord_vertical + 10 && ball_coord_vertical <= right_paddle_coord_vertical + 20) 
                            
                            reg_new_direction <= 9;             
                else if(ball_coord_horizontal == 670 && ball_coord_vertical >= right_paddle_coord_vertical + 20 && ball_coord_vertical <= right_paddle_coord_vertical + 30) 
                            
                            reg_new_direction <= 8;
                else if(ball_coord_horizontal == 670 && ball_coord_vertical >= right_paddle_coord_vertical + 30 && ball_coord_vertical <= right_paddle_coord_vertical + 40) 
                            
                            reg_new_direction <= 7;
                else if(ball_coord_horizontal == 670 && ball_coord_vertical >= right_paddle_coord_vertical + 40 && ball_coord_vertical <= right_paddle_coord_vertical + 50) 
                            
                            reg_new_direction <= 6;
                            
                else if(ball_coord_horizontal == 225 && ball_coord_vertical >= 150 && ball_coord_vertical <= 460) //Collision with Left Border      
                        reg_stand <= 1; 

                else if(ball_coord_horizontal == 700 && ball_coord_vertical >= 150 && ball_coord_vertical <= 460) //Collision with Right Border           
                        reg_stand <= 1;            
                                                    
            end
        
        else 
            begin
                reg_new_direction <= reg_new_direction;
            end
    
    always@(posedge clk) // Always Block for the Score Incrementation
        begin
        
            if(ball_coord_horizontal == 225 && ball_coord_vertical >= 150 && ball_coord_vertical <= 460) //Collision with Left Border      
                        reg_isactive_in_player_1 <= 1; 
                        
            else if(ball_coord_horizontal == 700 && ball_coord_vertical >= 150 && ball_coord_vertical <= 460) //Collision with Right Border           
                        reg_isactive_in_player_2 <= 1;    
            
            else 
                begin
                    
                    reg_isactive_in_player_1 <= 0;
                    reg_isactive_in_player_2 <= 0;
                    
                end
                              
            prev_reg_isactive_in_player_1 <= reg_isactive_in_player_1;
            prev_reg_isactive_in_player_2 <= reg_isactive_in_player_2;       
                    
        end
            
assign new_direction = reg_new_direction;     
assign stand_out = reg_stand; 

assign isactive_in_player_1 = reg_isactive_in_player_1 & ~prev_reg_isactive_in_player_1;
assign isactive_in_player_2 = reg_isactive_in_player_2 & ~prev_reg_isactive_in_player_2;
       
endmodule
