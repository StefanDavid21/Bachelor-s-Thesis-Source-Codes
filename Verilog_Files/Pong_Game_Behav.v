`timescale 1ns / 1ps

module Pong_Game_Behav
    
    (
        input clk, 
        input reset_to_start, 
        input reset_to_checkpoint, 
        input stand, 
        input [7:0] ps2_data_out,
        input [3:0] paddle_movement, 
        
        output [15:0] left_paddle_vertical, 
        output [15:0] right_paddle_vertical, 
        
        output [15:0] ball_coord_horizontal, 
        output [15:0] ball_coord_vertical, 
        
        output player_1_isactive_0,
        output player_1_isactive_1,
        output player_1_isactive_2,
        output player_1_isactive_3,
        output player_1_isactive_4,
        output player_1_isactive_5, 
        
        output player_2_isactive_0,
        output player_2_isactive_1,
        output player_2_isactive_2,
        output player_2_isactive_3,
        output player_2_isactive_4,
        output player_2_isactive_5, 
        output audio_pong 
        
        //output player_1_win_isactive, 
        //output player_2_win_isactive
        
    );
    
    wire [3:0] wire_new_direction; 
    wire [15:0] wire_left_paddle_coord, wire_right_paddle_coord; 
    wire [15:0] wire_ball_coord_horizontal, wire_ball_coord_vertical; 
    wire w_stand_out; 
    wire w_isactive_in_player_1, w_isactive_in_player_2; 
    
    wire [5:0] reg_left_paddle_score_isactive, reg_right_paddle_score_isactive; 
    
    Paddle_Movement_Module Paddle_Movement
    (
        
        .clk(clk), 
        .reset_to_start(reset_to_start || reset_to_checkpoint),
        .stand(stand || w_stand_out), 
        .ps2_data_out(ps2_data_out),
        .paddle_movement(paddle_movement), 
        
        .last_left_paddle_vertical(wire_left_paddle_coord), 
        .last_right_paddle_vertical(wire_right_paddle_coord), 
        
        .left_paddle_vertical(wire_left_paddle_coord), 
        .right_paddle_vertical(wire_right_paddle_coord)
          
    );
    
    Ball_Direction_Change_Module Direction_Change
    (
        .clk(clk), 
        .reset_to_start(reset_to_start || reset_to_checkpoint), 
        .stand(stand || w_stand_out), 
        .direction(wire_new_direction), 
        
        .left_paddle_coord_vertical(wire_left_paddle_coord), 
        .right_paddle_coord_vertical(wire_right_paddle_coord), 
        
        .ball_coord_horizontal(wire_ball_coord_horizontal), 
        .ball_coord_vertical(wire_ball_coord_vertical),
        
        
        .new_direction(wire_new_direction), 
        .stand_out(w_stand_out), 
        .isactive_in_player_1(w_isactive_in_player_1),
        .isactive_in_player_2(w_isactive_in_player_2) 
    );
    
    Ball_Movement Ball_Coords
    (
        .clk(clk), 
        .reset_to_start(reset_to_start || reset_to_checkpoint),
        .direction(wire_new_direction), 
        .stand(stand || w_stand_out),
        
        .ball_position_horizontal(wire_ball_coord_horizontal),
        .ball_position_vertical(wire_ball_coord_vertical)  
    
        
    );
    
    Score_Logic_Module_Pong Left_Paddle_Score
    
    (
        .clk(clk), 
        .is_active_in(w_isactive_in_player_1), 
        .rst(reset_to_start), 
        
        .isactive_0(reg_left_paddle_score_isactive[0]),
        .isactive_1(reg_left_paddle_score_isactive[1]),
        .isactive_2(reg_left_paddle_score_isactive[2]),
        .isactive_3(reg_left_paddle_score_isactive[3]),
        .isactive_4(reg_left_paddle_score_isactive[4]),
        .isactive_5(reg_left_paddle_score_isactive[5])
    );
    
    Score_Logic_Module_Pong Right_Paddle_Score
    
    (
        .clk(clk), 
        .is_active_in(w_isactive_in_player_2), 
        .rst(reset_to_start), 
        
        .isactive_0(reg_right_paddle_score_isactive[0]),
        .isactive_1(reg_right_paddle_score_isactive[1]),
        .isactive_2(reg_right_paddle_score_isactive[2]),
        .isactive_3(reg_right_paddle_score_isactive[3]),
        .isactive_4(reg_right_paddle_score_isactive[4]),
        .isactive_5(reg_right_paddle_score_isactive[5])
    );
    
    /*Win_Logic_Pong Win_Logic_Pong
    
    (
     
        .player_1_isactive_5(reg_left_paddle_score_isactive[5]), 
        .player_2_isactive_5(reg_right_paddle_score_isactive[5]), 
        
        .player_1_win_isactive(player_1_win_isactive), 
        .player_2_win_isactive(player_2_win_isactive) 
        
    );*/
    
    
    assign left_paddle_vertical = wire_left_paddle_coord; 
    assign right_paddle_vertical = wire_right_paddle_coord; 
    assign ball_coord_horizontal = wire_ball_coord_horizontal; 
    assign ball_coord_vertical = wire_ball_coord_vertical; 
    
    assign player_1_isactive_0 = reg_left_paddle_score_isactive[0];
    assign player_1_isactive_1 = reg_left_paddle_score_isactive[1];
    assign player_1_isactive_2 = reg_left_paddle_score_isactive[2];
    assign player_1_isactive_3 = reg_left_paddle_score_isactive[3];
    assign player_1_isactive_4 = reg_left_paddle_score_isactive[4]; 
    assign player_1_isactive_5 = reg_left_paddle_score_isactive[5];
    
    assign player_2_isactive_0 = reg_right_paddle_score_isactive[0];
    assign player_2_isactive_1 = reg_right_paddle_score_isactive[1];
    assign player_2_isactive_2 = reg_right_paddle_score_isactive[2];
    assign player_2_isactive_3 = reg_right_paddle_score_isactive[3];
    assign player_2_isactive_4 = reg_right_paddle_score_isactive[4]; 
    assign player_2_isactive_5 = reg_right_paddle_score_isactive[5];
    
    assign audio_pong = (w_isactive_in_player_1 || w_isactive_in_player_2); 
endmodule
