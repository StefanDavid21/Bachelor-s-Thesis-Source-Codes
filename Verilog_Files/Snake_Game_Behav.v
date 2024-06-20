`timescale 1ns / 1ps

module Snake_Game_Behav
    
    (
        input clk_1Hz, 
        input clk_5Hz, 
        input clk_25Khz, 
        input clk_25Mhz, 
        
        input [15:0] random_h_count_value, 
        input [15:0] random_v_count_value,
        
        input [7:0] ps2_data_out, 
        input reset_to_start,
        //input stand, 
        
        input isactive_digit_forced,
        
        
        output reset_lfsr, 
        output isactive_lfsr,
        
        output isactive_0, 
        output isactive_1,
        output isactive_2,
        output isactive_3,
        output isactive_4,
        output isactive_5,
        output isactive_6,
        output isactive_7,
        output isactive_8,
        output isactive_9,
        
        output isactive_part_0, 
        output isactive_part_1,
        output isactive_part_2,
        output isactive_part_3,
        output isactive_part_4,
        output isactive_part_5,
        output isactive_part_6,
        output isactive_part_7,
        output isactive_part_8,
        output isactive_part_9,
        
        output isactive_you_lose, 
        output isactive_you_win,
        
        output wire_stand, 
        
        output wire [10:0] horizontal_part_0_coord, 
        output wire [10:0] vertical_part_0_coord,
        output wire [10:0] horizontal_part_1_coord, 
        output wire [10:0] vertical_part_1_coord, 
        output wire [10:0] horizontal_part_2_coord, 
        output wire [10:0] vertical_part_2_coord,
        output wire [10:0] horizontal_part_3_coord, 
        output wire [10:0] vertical_part_3_coord,
        output wire [10:0] horizontal_part_4_coord, 
        output wire [10:0] vertical_part_4_coord,
        output wire [10:0] horizontal_part_5_coord, 
        output wire [10:0] vertical_part_5_coord,
        output wire [10:0] horizontal_part_6_coord, 
        output wire [10:0] vertical_part_6_coord,
        output wire [10:0] horizontal_part_7_coord, 
        output wire [10:0] vertical_part_7_coord,
        output wire [10:0] horizontal_part_8_coord, 
        output wire [10:0] vertical_part_8_coord,
        output wire [10:0] horizontal_part_9_coord, 
        output wire [10:0] vertical_part_9_coord,
        output wire [10:0] horizontal_part_10_coord, 
        output wire [10:0] vertical_part_10_coord,
        
        output wire audio_snake
    );
    
    wire [10:0] head_modified_position_horizontal,head_modified_position_vertical;        
    wire w_isactive_digit, w_reset_digit; 
    wire w_enable_shift_reg;
    wire you_lose_from_collision; 
            
    Score_Logic_Module_Snake M45
    
    (
        .clk(clk_5Hz), 
        .is_active_in(w_isactive_digit), 
        .rst(w_reset_digit), 
        
        .isactive_0(isactive_0),
        .isactive_1(isactive_1),
        .isactive_2(isactive_2),
        .isactive_3(isactive_3),
        .isactive_4(isactive_4),
        .isactive_5(isactive_5),
        .isactive_6(isactive_6),
        .isactive_7(isactive_7),
        .isactive_8(isactive_8),
        .isactive_9(isactive_9)
           
    );
    
    Activation_Snake_Parts M46
    
    (
        .clk(clk_5Hz), 
        .is_active_in(w_isactive_digit), 
        .rst(w_reset_digit), 
        
        .isactive_part_0(isactive_part_0),
        .isactive_part_1(isactive_part_1),
        .isactive_part_2(isactive_part_2),
        .isactive_part_3(isactive_part_3),
        .isactive_part_4(isactive_part_4),
        .isactive_part_5(isactive_part_5),
        .isactive_part_6(isactive_part_6),
        .isactive_part_7(isactive_part_7),
        .isactive_part_8(isactive_part_8),
        .isactive_part_9(isactive_part_9) 

    );
            
    Snake_Game_Logic_Menu_V2 Snake_Logic
    
    (
    
        .clk(clk_5Hz),
        .ps2_data_out(ps2_data_out),
        
        .reset_to_start(reset_to_start),
        .isactive_9(isactive_9),
        
        .horizontal_lfsr(random_h_count_value), 
        .vertical_lfsr(random_v_count_value),
        .you_lose_from_collision(you_lose_from_collision),
        
        .isactive_digit(w_isactive_digit), 
        .reset_digit(w_reset_digit),
        
        .isactive_lfsr(isactive_lfsr), 
        .reset_lfsr(reset_lfsr),
        .enable_shift_register(w_enable_shift_reg), 
        
        .isactive_you_lose(isactive_you_lose),
        .isactive_you_win(isactive_you_win),
        
        .head_modified_position_horizontal(head_modified_position_horizontal),
        .head_modified_position_vertical(head_modified_position_vertical),
        .wire_stand(wire_stand)
    );
    
   Snake_Part_Shift_Reg Snake_Parts_Positions
   (
        .clock(clk_5Hz),
        .reset(reset_to_start),
        .enable(w_enable_shift_reg),
        
        .isactive_part_0(isactive_part_0),
        .isactive_part_1(isactive_part_1),
        .isactive_part_2(isactive_part_2),
        .isactive_part_3(isactive_part_3),
        .isactive_part_4(isactive_part_4),
        .isactive_part_5(isactive_part_5),
        .isactive_part_6(isactive_part_6),
        .isactive_part_7(isactive_part_7),
        .isactive_part_8(isactive_part_8),
        .isactive_part_9(isactive_part_9), 
        
        .horizontal_head_coord(head_modified_position_horizontal),
        .vertical_head_coord(head_modified_position_vertical),
        
        .horizontal_part_0_coord(horizontal_part_0_coord), 
        .vertical_part_0_coord(vertical_part_0_coord),
        
        .horizontal_part_1_coord(horizontal_part_1_coord), 
        .vertical_part_1_coord(vertical_part_1_coord), 
        
        .horizontal_part_2_coord(horizontal_part_2_coord), 
        .vertical_part_2_coord(vertical_part_2_coord),
        
        .horizontal_part_3_coord(horizontal_part_3_coord), 
        .vertical_part_3_coord(vertical_part_3_coord),
        
        .horizontal_part_4_coord(horizontal_part_4_coord), 
        .vertical_part_4_coord(vertical_part_4_coord),
        
        .horizontal_part_5_coord(horizontal_part_5_coord), 
        .vertical_part_5_coord(vertical_part_5_coord),
        
        .horizontal_part_6_coord(horizontal_part_6_coord), 
        .vertical_part_6_coord(vertical_part_6_coord),
        
        .horizontal_part_7_coord(horizontal_part_7_coord), 
        .vertical_part_7_coord(vertical_part_7_coord),
        
        .horizontal_part_8_coord(horizontal_part_8_coord), 
        .vertical_part_8_coord(vertical_part_8_coord),
        
        .horizontal_part_9_coord(horizontal_part_9_coord), 
        .vertical_part_9_coord(vertical_part_9_coord),
        
        .horizontal_part_10_coord(horizontal_part_10_coord), 
        .vertical_part_10_coord(vertical_part_10_coord), 
        .you_lose_from_collision(you_lose_from_collision)
    
    );
    
    assign audio_snake = w_isactive_digit; 
        
endmodule
