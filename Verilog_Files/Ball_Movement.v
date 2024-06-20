`timescale 1ns / 1ps

module Ball_Movement
    (
        input clk, 
        input reset_to_start,
        input [3:0] direction, 
        input stand,
        
        output [10:0] ball_position_horizontal,
        output [10:0] ball_position_vertical  
    
        
    );
    
    reg [15:0] reg_ball_position_horizontal; 
    reg [15:0] reg_ball_position_vertical; 
    reg toggle_direction; 
    
    always@(posedge clk)
        begin
        
            if(reset_to_start)
                begin
                     
                     reg_ball_position_horizontal <= 400; 
                     reg_ball_position_vertical <= 325;
                     toggle_direction <= 1; 
                                       
                    
                end
            
            else if(!stand)
                begin
                
                    case(direction) 
                    
                        1: begin      //Right, Up, 45 degr
                                
                                reg_ball_position_horizontal <= reg_ball_position_horizontal + 5;
                                reg_ball_position_vertical <= reg_ball_position_vertical - 5;  
                                
                           end
                        
                        2: begin     //Right, Up, 30 degr
                                
                                if(toggle_direction)
                                    
                                    begin
                                        reg_ball_position_horizontal <= reg_ball_position_horizontal + 5;
                                        reg_ball_position_vertical <= reg_ball_position_vertical;
                                        toggle_direction <= 0;                                             
                                    end        
                                else
                                    begin
                                        reg_ball_position_horizontal <= reg_ball_position_horizontal + 5;
                                        reg_ball_position_vertical <= reg_ball_position_vertical  - 5;        
                                        toggle_direction <= 1;                                                                                  
                                    end
                                               
                           end    
                        
                        3: begin    //Right, Front
                                
                                reg_ball_position_horizontal <= reg_ball_position_horizontal + 5;
                                reg_ball_position_vertical <= reg_ball_position_vertical;    
                           
                           end
                           
                        4: begin     //Right, Down, 30 degr
                                
                                if(toggle_direction)
                                    
                                    begin
                                        reg_ball_position_horizontal <= reg_ball_position_horizontal + 5;
                                        reg_ball_position_vertical <= reg_ball_position_vertical;
                                        toggle_direction <= 0;                                             
                                    end        
                                else
                                    begin
                                        reg_ball_position_horizontal <= reg_ball_position_horizontal + 5;
                                        reg_ball_position_vertical <= reg_ball_position_vertical  + 5;        
                                        toggle_direction <= 1;                                                                                  
                                    end
                                               
                           end    
                        
                        5: begin    //Right, Down, 45 degr
                        
                                reg_ball_position_horizontal <= reg_ball_position_horizontal + 5;
                                reg_ball_position_vertical <= reg_ball_position_vertical + 5;    
                           
                           end
                           
                        6: begin    //Left, Down, 45 degr
                        
                                reg_ball_position_horizontal <= reg_ball_position_horizontal - 5;
                                reg_ball_position_vertical <= reg_ball_position_vertical + 5;    
                           
                           end
                           
                        7: begin     //Left, Down, 30 degr
                                
                                if(toggle_direction)
                                    
                                    begin
                                        reg_ball_position_horizontal <= reg_ball_position_horizontal - 5;
                                        reg_ball_position_vertical <= reg_ball_position_vertical;
                                        toggle_direction <= 0;                                             
                                    end        
                                else
                                    begin
                                        reg_ball_position_horizontal <= reg_ball_position_horizontal - 5;
                                        reg_ball_position_vertical <= reg_ball_position_vertical  + 5;        
                                        toggle_direction <= 1;                                                                                  
                                    end
                                               
                           end    
                        
                        8: begin    //Left, Front
                        
                                reg_ball_position_horizontal <= reg_ball_position_horizontal - 5;
                                reg_ball_position_vertical <= reg_ball_position_vertical;        
                           
                           end
                           
                        9: begin     //Left, Up, 30 degr
                                
                                if(toggle_direction)
                                    
                                    begin
                                        reg_ball_position_horizontal <= reg_ball_position_horizontal - 5;
                                        reg_ball_position_vertical <= reg_ball_position_vertical;
                                        toggle_direction <= 0;                                             
                                    end        
                                else
                                    begin
                                        reg_ball_position_horizontal <= reg_ball_position_horizontal - 5;
                                        reg_ball_position_vertical <= reg_ball_position_vertical  - 5;        
                                        toggle_direction <= 1;                                                                                  
                                    end
                                               
                           end    
                           
                        10: begin   //Left, Up, 45 degr
                        
                                reg_ball_position_horizontal <= reg_ball_position_horizontal - 5;
                                reg_ball_position_vertical <= reg_ball_position_vertical -5;    
                            
                           end                     
                        default: 
                            begin
                                    reg_ball_position_horizontal <= reg_ball_position_horizontal;
                                    reg_ball_position_vertical <= reg_ball_position_vertical;
                            end
                              
                    endcase
                
                                    
                end
                
            else 
                begin 
                        reg_ball_position_horizontal <= reg_ball_position_horizontal;
                        reg_ball_position_vertical <= reg_ball_position_vertical;                   
                end            
        end

assign ball_position_horizontal = reg_ball_position_horizontal; 
assign ball_position_vertical = reg_ball_position_vertical; 
    
endmodule
