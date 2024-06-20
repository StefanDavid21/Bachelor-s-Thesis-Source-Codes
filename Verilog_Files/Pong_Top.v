`timescale 1ns / 1ps

/* YOU NEED TO SELECT AN OFFSET TO CHOOSE THE RIGHT SYMBOL
    
    Offset Value Legend: 
    
    1 -> M high (4 fsm)
    2 -> E high (4 fsm) 
    3 -> N high (3 fsm) 
    4 -> U high  (3 fsm)
    5 -> P  (4 fsm)
    6 -> O  (4 fsm)
    7 -> N   (3 fsm)
    8 -> G  (5 fsm)
    9 -> S  (5)
    10 -> A  (3)
    11 -> K  (3)
    12 -> E (4)
    13 -> C  (3)
    14 -> I (2)
    15 -> V (2)
    16 -> D  (4)
    17 -> R  (5)
    18 -> 'right arrow' (3)
    19 -> ! (2)
    20 -> :  (2)
    21 -> Y  (3)
    22 -> U  (3)
    23 -> W (4)
    
    24 -> 0 (4) 
    25 -> 1 (1)
    26 -> 2 (5)
    27 -> 3 (4)
    28 -> 4 (3)
    29 -> 5 (5) 
    30 -> 6 (5)
    31 -> 7 (2)
    32 -> 8 (5) 
    33 -> 9 (5) 
    34 -> L (2)
       
 */

module Pong_Top
    (
        input clk,               
        input isactive,          
        input [7:0] ps2_data_out,
        input reset_to_start_pong,
        input reset_to_checkpoint_pong,
        input stand,
        input [3:0] paddle_movement, 
        
        output [18:0] address_write,
        output [11:0] data_write,
        output audio_pong
    );
    
    // Data and wire declarations
        
        wire clk_25Mhz, clk_25Khz, clk_1Hz, clk_5Hz, clk_20Hz;
        wire enable_v_counter; 
        wire [15:0] h_count_value; 
        wire [15:0] v_count_value;
        
        parameter number_of_fsm = 29; 
        wire[11:0] data_write_wire[number_of_fsm-1 : 0];
        wire[18:0] address_write_wire[number_of_fsm-1 : 0];
        reg [18:0] address_test [number_of_fsm - 1 : 0]; 
        reg [11:0] data_test [number_of_fsm - 1 : 0];
        
        wire [15:0] left_paddle_vertical, right_paddle_vertical;
        wire [15:0] ball_coord_horizontal, ball_coord_vertical;  
        
        wire w_player_1_isactive_0 ,w_player_1_isactive_1, w_player_1_isactive_2, w_player_1_isactive_3, w_player_1_isactive_4, w_player_1_isactive_5; 
        wire w_player_2_isactive_0 ,w_player_2_isactive_1, w_player_2_isactive_2, w_player_2_isactive_3, w_player_2_isactive_4, w_player_2_isactive_5; 
        
        wire w_player_1_win_isactive, w_player_2_win_isactive;
        
        
        integer j;
    
    
    
    // Modules for counting (clk divider + h_count + w_count)
        
            clk_divider m0
        (
            .clk(clk), 
            .divided_clk(clk_25Mhz)      
        );
        
        clk_divider_25Khz m3
        (
            .clk(clk), //100Mhz
            .divided_clk(clk_25Khz)      
        );
        
        clk_divider_1Hz m777
        (
            .clk(clk), //100Mhz
            .divided_clk(clk_1Hz)      
        );
        
        clk_divider_5Hz m7771
        (
            .clk(clk), //100Mhz
            .divided_clk(clk_5Hz)      
        );
        
        clk_divider_20Hz m77711
        (
            .clk(clk), //100Mhz
            .divided_clk(clk_20Hz)      
        );
        
        horizontal_counter m1
        (
            .clk_25Mhz(clk_25Mhz), 
            .enable_v_counter(enable_v_counter), 
            .h_count_value(h_count_value)
    
        );
        
        vertical_counter m2
        (
            .clk_25Mhz(clk_25Mhz), 
            .enable_v_counter(enable_v_counter), 
            .v_count_value(v_count_value)
    
        );
    
    
    // Behave Module for Pong Game
       
       Pong_Game_Behav Pong_Behave_Module
    
    (
        .clk(clk_20Hz), 
        .reset_to_start(reset_to_start_pong), 
        .reset_to_checkpoint(reset_to_checkpoint_pong),
        .stand(stand),
        .ps2_data_out(ps2_data_out),
        .paddle_movement(paddle_movement),
        
        .left_paddle_vertical(left_paddle_vertical), 
        .right_paddle_vertical(right_paddle_vertical), 
        
        .ball_coord_horizontal(ball_coord_horizontal), 
        .ball_coord_vertical(ball_coord_vertical), 
        
        .player_1_isactive_0(w_player_1_isactive_0),
        .player_1_isactive_1(w_player_1_isactive_1),
        .player_1_isactive_2(w_player_1_isactive_2),
        .player_1_isactive_3(w_player_1_isactive_3),
        .player_1_isactive_4(w_player_1_isactive_4),
        .player_1_isactive_5(w_player_1_isactive_5), 
                            
        .player_2_isactive_0(w_player_2_isactive_0),
        .player_2_isactive_1(w_player_2_isactive_1),
        .player_2_isactive_2(w_player_2_isactive_2),
        .player_2_isactive_3(w_player_2_isactive_3),
        .player_2_isactive_4(w_player_2_isactive_4),
        .player_2_isactive_5(w_player_2_isactive_5),
        .audio_pong(audio_pong) 
        
        //.player_1_win_isactive(w_player_1_win_isactive), 
        //.player_2_win_isactive(w_player_2_win_isactive)
        
    ); 
        
    
    // Instantiate The Frames
        
        // Paddle Player 1 
        
        Draw_FSM_Rectangle_Unparameterized Paddle_Player_1

    
    (
        .clk(clk_25Mhz),
        
        .isactive(0),
        
        .horizontal_start_limit(240), 
        .vertical_start_limit(left_paddle_vertical),
        .horizontal_end_limit(250), 
        .vertical_end_limit(left_paddle_vertical + 50), 
        .color(2),
        
        .horizontal_actual_position(h_count_value),
        .vertical_actual_position(v_count_value),
        
        .addr(address_write_wire[0]), 
        .data_out(data_write_wire[0])

    );
        
        // Paddle Player 2 
        
        Draw_FSM_Rectangle_Unparameterized Paddle_Player_2

    
    (
        .clk(clk_25Mhz),
        
        .isactive(0),
        
        .horizontal_start_limit(680), 
        .vertical_start_limit(right_paddle_vertical),
        .horizontal_end_limit(690), 
        .vertical_end_limit(right_paddle_vertical + 50), 
        .color(2),
        
        .horizontal_actual_position(h_count_value),
        .vertical_actual_position(v_count_value),
        
        .addr(address_write_wire[1]), 
        .data_out(data_write_wire[1])

    );
        
        
        
        // Ball
        
        Draw_FSM_Rectangle_Unparameterized Ball

    
    (
        .clk(clk_25Mhz),
        
        .isactive(0),
        
        .horizontal_start_limit(ball_coord_horizontal), 
        .vertical_start_limit(ball_coord_vertical),
        .horizontal_end_limit(ball_coord_horizontal + 5), 
        .vertical_end_limit(ball_coord_vertical + 5), 
        .color(2),
        
        .horizontal_actual_position(h_count_value),
        .vertical_actual_position(v_count_value),
        
        .addr(address_write_wire[2]), 
        .data_out(data_write_wire[2])

    );
        
        
        // Game Border 
    
    Draw_FSM_Rectangle # 
    /*Parameter*/ (.horizontal_start_limit(210), .vertical_start_limit(150), .horizontal_end_limit(720), .vertical_end_limit(160), .color(4))
    /*Name of Instance*/ Up_Border
    /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
    
    Draw_FSM_Rectangle # 
    /*Parameter*/ (.horizontal_start_limit(210), .vertical_start_limit(450), .horizontal_end_limit(720), .vertical_end_limit(460), .color(4))
    /*Name of Instance*/ Down_Border
    /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[4]), .data_out(data_write_wire[4]));   
    
    Draw_FSM_Rectangle # 
    /*Parameter*/ (.horizontal_start_limit(210), .vertical_start_limit(150), .horizontal_end_limit(220), .vertical_end_limit(460), .color(4))
    /*Name of Instance*/ Left_Border
    /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[5]), .data_out(data_write_wire[5]));   
    
    Draw_FSM_Rectangle # 
    /*Parameter*/ (.horizontal_start_limit(710), .vertical_start_limit(150), .horizontal_end_limit(720), .vertical_end_limit(460), .color(4))
    /*Name of Instance*/ Right_Border
    /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[6]), .data_out(data_write_wire[6]));   
        
        // Score + Digits For Player 1
        
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(160), .vertical_start_limit(270), .color(4), .offset(24), .number_of_fsm(4))
    Digit_0
    ( .clk(clk), .isactive(w_player_1_isactive_0), .address_write(address_write_wire[12]), .data_write(data_write_wire[12]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(160), .vertical_start_limit(270), .color(4), .offset(25), .number_of_fsm(1))
    Digit_1
    ( .clk(clk), .isactive(w_player_1_isactive_1), .address_write(address_write_wire[13]), .data_write(data_write_wire[13]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(160), .vertical_start_limit(270), .color(4), .offset(26), .number_of_fsm(5))
    Digit_2
    ( .clk(clk), .isactive(w_player_1_isactive_2), .address_write(address_write_wire[14]), .data_write(data_write_wire[14]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(160), .vertical_start_limit(270), .color(4), .offset(27), .number_of_fsm(4))
    Digit_3
    ( .clk(clk), .isactive(w_player_1_isactive_3), .address_write(address_write_wire[15]), .data_write(data_write_wire[15]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(160), .vertical_start_limit(270), .color(4), .offset(28), .number_of_fsm(3))
    Digit_4
    ( .clk(clk), .isactive(w_player_1_isactive_4), .address_write(address_write_wire[16]), .data_write(data_write_wire[16]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(160), .vertical_start_limit(270), .color(4), .offset(29), .number_of_fsm(5))
    Digit_5
    ( .clk(clk), .isactive(w_player_1_isactive_5), .address_write(address_write_wire[17]), .data_write(data_write_wire[17]));
    
       
        // Score + Digits For Player 2 
        
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(730), .vertical_start_limit(270), .color(4), .offset(24), .number_of_fsm(4))
    Digit_0_2
    ( .clk(clk), .isactive(w_player_2_isactive_0), .address_write(address_write_wire[23]), .data_write(data_write_wire[23]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(730), .vertical_start_limit(270), .color(4), .offset(25), .number_of_fsm(1))
    Digit_1_2
    ( .clk(clk), .isactive(w_player_2_isactive_1), .address_write(address_write_wire[24]), .data_write(data_write_wire[24]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(730), .vertical_start_limit(270), .color(4), .offset(26), .number_of_fsm(5))
    Digit_2_2
    ( .clk(clk), .isactive(w_player_2_isactive_2), .address_write(address_write_wire[25]), .data_write(data_write_wire[25]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(730), .vertical_start_limit(270), .color(4), .offset(27), .number_of_fsm(4))
    Digit_3_2
    ( .clk(clk), .isactive(w_player_2_isactive_3), .address_write(address_write_wire[26]), .data_write(data_write_wire[26]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(730), .vertical_start_limit(270), .color(4), .offset(28), .number_of_fsm(3))
    Digit_4_2
    ( .clk(clk), .isactive(w_player_2_isactive_4), .address_write(address_write_wire[27]), .data_write(data_write_wire[27]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(730), .vertical_start_limit(270), .color(4), .offset(29), .number_of_fsm(5))
    Digit_5_2
    ( .clk(clk), .isactive(w_player_2_isactive_5), .address_write(address_write_wire[28]), .data_write(data_write_wire[28]));
        
        
 
    // Multiplexing the Data_Out signal
    
    always@(posedge clk_25Mhz)
        begin
            address_test[0] = address_write_wire[0];
            data_test[0] = data_write_wire[0];
        end


    always@(posedge clk_25Mhz)
  begin
          
       for(j = 1; j < number_of_fsm; j = j + 1) 
        begin
            
            data_test[j] = (data_test[j-1] != 0) ? ((data_write_wire[j] != 0) ? (data_test[j-1] & data_write_wire[j]) : data_test[j-1]) : data_write_wire[j];

        end
  end 
   
   
  assign address_write = address_test[0]; 
  assign data_write = (isactive) ? data_test[number_of_fsm - 1] : 12'b000000000000 ;
    
    
endmodule
