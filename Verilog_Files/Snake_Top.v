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

module Snake_Top
    (
        
        input clk,
        input isactive,
        input [7:0] ps2_data_out,    
        input reset_button_for_snake, //Manual Reset for snake game
        input reset_forced_lfsr,      // Manual Reset for lfsr
        input direction_left_forced,
        input isactive_digit_forced,
        
        output [18:0] address_write,
        output [11:0] data_write, 
        output led_test,
        output audio_snake

    );

// Data and wire declarations 
    
    wire reset_lfsr, isactive_lfsr, reset_digit, isactive_digit;
    
    wire w_reset_lfsr, w_isactive_lfsr; 
    
    wire clk_25Mhz, clk_25Khz, clk_1Hz, clk_5Hz;
    wire enable_v_counter; 
    wire [15:0] h_count_value; 
    wire [15:0] v_count_value; 
    
    wire [10:0] horizontal_start_limit_snake [10:0];
    wire [10:0] vertical_start_limit_snake [10:0];
    
    wire [10:0] head_modified_position_horizontal, head_modified_position_vertical; 
    
    parameter number_of_fsm = 47; 
    wire[11:0] data_write_wire[number_of_fsm-1 : 0];
    wire[18:0] address_write_wire[number_of_fsm-1 : 0];
    reg [18:0] address_test [number_of_fsm - 1 : 0]; 
    reg [11:0] data_test [number_of_fsm - 1 : 0];
    
    integer j;
    
    wire [15:0] random_h_count_value; 
    wire [15:0] random_v_count_value;
    
    wire isactive_0, isactive_1, isactive_3, isactive_4, isactive_5, isactive_6, isactive_7, isactive_8, isactive_9; 
    wire isactive_snake_0, isactive_snake_1, isactive_snake_2, isactive_snake_3, isactive_snake_4, isactive_snake_5, 
         isactive_snake_6, isactive_snake_7, isactive_snake_8, isactive_snake_9; 
    
    wire w_isactive_you_lose, w_isactive_you_win; 
    
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
    

// Instantiate The LFSR's for Random coordinates generation 
   
   LFSR_Width LFSR1
   
   (
    
   .clk(clk_25Mhz),
   .reset(w_reset_lfsr),
   .is_active(w_isactive_lfsr || reset_forced_lfsr),
   .random_number(random_h_count_value)
   
    );
    
    LFSR_Height LFSR2 
    
    (
    
    .clk(clk_25Mhz),
    .reset(w_reset_lfsr),
    .is_active(w_isactive_lfsr || reset_forced_lfsr),
    .random_number(random_v_count_value)
    
    );    
 
// Behave Module for Snake Game 
   
   Snake_Game_Behav Module_X
    
    (
        .clk_1Hz(clk_1Hz), 
        .clk_5Hz(clk_5Hz), 
        .clk_25Khz(clk_25Khz), 
        .clk_25Mhz(clk_25Mhz), 
        
        .random_h_count_value(random_h_count_value), 
        .random_v_count_value(random_v_count_value),
        
        .isactive_digit_forced(isactive_digit_forced),
        
        .ps2_data_out(ps2_data_out), 
        .reset_to_start(reset_button_for_snake),
        
        .reset_lfsr(w_reset_lfsr), 
        .isactive_lfsr(w_isactive_lfsr),
        
        .isactive_0(isactive_0), 
        .isactive_1(isactive_1),
        .isactive_2(isactive_2),
        .isactive_3(isactive_3),
        .isactive_4(isactive_4),
        .isactive_5(isactive_5),
        .isactive_6(isactive_6),
        .isactive_7(isactive_7),
        .isactive_8(isactive_8),
        .isactive_9(isactive_9),
        .wire_stand(),
        
        .isactive_part_0(isactive_snake_0), 
        .isactive_part_1(isactive_snake_1),
        .isactive_part_2(isactive_snake_2),
        .isactive_part_3(isactive_snake_3),
        .isactive_part_4(isactive_snake_4),
        .isactive_part_5(isactive_snake_5),
        .isactive_part_6(isactive_snake_6),
        .isactive_part_7(isactive_snake_7),
        .isactive_part_8(isactive_snake_8),
        .isactive_part_9(isactive_snake_9),
        
        .horizontal_part_0_coord(horizontal_start_limit_snake[0]), 
        .vertical_part_0_coord(vertical_start_limit_snake[0]),
        .horizontal_part_1_coord(horizontal_start_limit_snake[1]), 
        .vertical_part_1_coord(vertical_start_limit_snake[1]), 
        .horizontal_part_2_coord(horizontal_start_limit_snake[2]), 
        .vertical_part_2_coord(vertical_start_limit_snake[2]),
        .horizontal_part_3_coord(horizontal_start_limit_snake[3]), 
        .vertical_part_3_coord(vertical_start_limit_snake[3]),
        .horizontal_part_4_coord(horizontal_start_limit_snake[4]), 
        .vertical_part_4_coord(vertical_start_limit_snake[4]),
        .horizontal_part_5_coord(horizontal_start_limit_snake[5]), 
        .vertical_part_5_coord(vertical_start_limit_snake[5]),
        .horizontal_part_6_coord(horizontal_start_limit_snake[6]), 
        .vertical_part_6_coord(vertical_start_limit_snake[6]),
        .horizontal_part_7_coord(horizontal_start_limit_snake[7]), 
        .vertical_part_7_coord(vertical_start_limit_snake[7]),
        .horizontal_part_8_coord(horizontal_start_limit_snake[8]), 
        .vertical_part_8_coord(vertical_start_limit_snake[8]),
        .horizontal_part_9_coord(horizontal_start_limit_snake[9]), 
        .vertical_part_9_coord(vertical_start_limit_snake[9]),
        .horizontal_part_10_coord(horizontal_start_limit_snake[10]), 
        .vertical_part_10_coord(vertical_start_limit_snake[10]),
        
        .isactive_you_lose(w_isactive_you_lose), 
        .isactive_you_win(w_isactive_you_win),
        .audio_snake(audio_snake)  
    );    

        
    
// Instantiate The Frames 

    //Apple 
    
    Draw_FSM_Rectangle_Unparameterized Apple

    
    (
        .clk(clk_25Mhz),
        
        .isactive(w_isactive_lfsr || reset_forced_lfsr),
        
        .horizontal_start_limit(random_h_count_value), 
        .vertical_start_limit(random_v_count_value),
        .horizontal_end_limit(random_h_count_value + 10), 
        .vertical_end_limit(random_v_count_value + 10), 
        .color(2),
        
        .horizontal_actual_position(h_count_value),
        .vertical_actual_position(v_count_value),
        
        .addr(address_write_wire[0]), 
        .data_out(data_write_wire[0])

    );
            
    // Game Border 
    
    Draw_FSM_Rectangle # 
    /*Parameter*/ (.horizontal_start_limit(210), .vertical_start_limit(200), .horizontal_end_limit(720), .vertical_end_limit(210), .color(2))
    /*Name of Instance*/ Up_Border
    /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
    
    Draw_FSM_Rectangle # 
    /*Parameter*/ (.horizontal_start_limit(210), .vertical_start_limit(460), .horizontal_end_limit(720), .vertical_end_limit(470), .color(2))
    /*Name of Instance*/ Down_Border
    /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
    
    Draw_FSM_Rectangle # 
    /*Parameter*/ (.horizontal_start_limit(210), .vertical_start_limit(200), .horizontal_end_limit(220), .vertical_end_limit(470), .color(2))
    /*Name of Instance*/ Left_Border
    /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
    
    Draw_FSM_Rectangle # 
    /*Parameter*/ (.horizontal_start_limit(710), .vertical_start_limit(200), .horizontal_end_limit(720), .vertical_end_limit(470), .color(2))
    /*Name of Instance*/ Right_Border
    /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[4]), .data_out(data_write_wire[4]));   
    
    // Score + Digits (Ex: 'SCORE : 1') 
    
    Draw_Symbol #
    ( .horizontal_start_limit(330), .vertical_start_limit(150), .color(2), .offset(9), .isactive(1), .number_of_fsm(5))
    S
    ( .clk(clk), .address_write(address_write_wire[5]), .data_write(data_write_wire[5]));  
    
    Draw_Symbol #
    ( .horizontal_start_limit(380), .vertical_start_limit(150), .color(2), .offset(13), .isactive(1), .number_of_fsm(3))
    C
    ( .clk(clk), .address_write(address_write_wire[6]), .data_write(data_write_wire[6])); 
    
    Draw_Symbol #
    ( .horizontal_start_limit(430), .vertical_start_limit(150), .color(2), .offset(6), .isactive(1), .number_of_fsm(4))
    O
    ( .clk(clk), .address_write(address_write_wire[7]), .data_write(data_write_wire[7]));
    
    Draw_Symbol #
    ( .horizontal_start_limit(480), .vertical_start_limit(150), .color(2), .offset(17), .isactive(1), .number_of_fsm(5))
    R
    ( .clk(clk), .address_write(address_write_wire[8]), .data_write(data_write_wire[8]));
    
    Draw_Symbol #
    ( .horizontal_start_limit(510), .vertical_start_limit(150), .color(2), .offset(12), .isactive(1), .number_of_fsm(4))
    E
    ( .clk(clk), .address_write(address_write_wire[9]), .data_write(data_write_wire[9]));
    
    Draw_Symbol #
    ( .horizontal_start_limit(530), .vertical_start_limit(150), .color(2), .offset(20), .isactive(1), .number_of_fsm(2))
    Dots
    ( .clk(clk), .address_write(address_write_wire[10]), .data_write(data_write_wire[10]));         
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(570), .vertical_start_limit(150), .color(2), .offset(24), .number_of_fsm(4))
    Digit_0
    ( .clk(clk), .isactive(isactive_0), .address_write(address_write_wire[11]), .data_write(data_write_wire[11]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(570), .vertical_start_limit(150), .color(2), .offset(25), .number_of_fsm(1))
    Digit_1
    ( .clk(clk), .isactive(isactive_1), .address_write(address_write_wire[12]), .data_write(data_write_wire[12]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(570), .vertical_start_limit(150), .color(2), .offset(26), .number_of_fsm(5))
    Digit_2
    ( .clk(clk), .isactive(isactive_2), .address_write(address_write_wire[13]), .data_write(data_write_wire[13]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(570), .vertical_start_limit(150), .color(2), .offset(27), .number_of_fsm(4))
    Digit_3
    ( .clk(clk), .isactive(isactive_3), .address_write(address_write_wire[14]), .data_write(data_write_wire[14]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(570), .vertical_start_limit(150), .color(2), .offset(28), .number_of_fsm(3))
    Digit_4
    ( .clk(clk), .isactive(isactive_4), .address_write(address_write_wire[15]), .data_write(data_write_wire[15]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(570), .vertical_start_limit(150), .color(2), .offset(29), .number_of_fsm(5))
    Digit_5
    ( .clk(clk), .isactive(isactive_5), .address_write(address_write_wire[16]), .data_write(data_write_wire[16]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(570), .vertical_start_limit(150), .color(2), .offset(30), .number_of_fsm(5))
    Digit_6
    ( .clk(clk), .isactive(isactive_6), .address_write(address_write_wire[17]), .data_write(data_write_wire[17]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(570), .vertical_start_limit(150), .color(2), .offset(31), .number_of_fsm(2))
    Digit_7
    ( .clk(clk), .isactive(isactive_7), .address_write(address_write_wire[18]), .data_write(data_write_wire[18]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(570), .vertical_start_limit(150), .color(2), .offset(32), .number_of_fsm(5))
    Digit_8
    ( .clk(clk), .isactive(isactive_8), .address_write(address_write_wire[19]), .data_write(data_write_wire[19]));
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(570), .vertical_start_limit(150), .color(2), .offset(33), .number_of_fsm(5))
    Digit_9
    ( .clk(clk), .isactive(isactive_9), .address_write(address_write_wire[20]), .data_write(data_write_wire[20]));
    
    //Snake 
    
    Snake_Part #
    (.color(4),.offset(1), .number_of_fsm(1), .index(0))
    Snake_part_0
    ( .horizontal_start_limit(horizontal_start_limit_snake[0]), .vertical_start_limit(vertical_start_limit_snake[0]), .clk(clk), .isactive(1), .address_write(address_write_wire[21]), .data_write(data_write_wire[21]));
    
    Snake_Part #
    ( .color(4),.offset(1), .number_of_fsm(1), .index(1))
    Snake_part_1
    ( .horizontal_start_limit(horizontal_start_limit_snake[1]), .vertical_start_limit(vertical_start_limit_snake[1]), .clk(clk), .isactive(isactive_snake_0), .address_write(address_write_wire[22]), .data_write(data_write_wire[22]));
    
    Snake_Part #
    ( .color(4),.offset(1), .number_of_fsm(1), .index(2))
    Snake_part_2
    ( .horizontal_start_limit(horizontal_start_limit_snake[2]), .vertical_start_limit(vertical_start_limit_snake[2]), .clk(clk), .isactive(isactive_snake_1), .address_write(address_write_wire[23]), .data_write(data_write_wire[23]));
    
    Snake_Part #
    ( .color(4),.offset(1), .number_of_fsm(1), .index(3))
    Snake_part_3
    ( .horizontal_start_limit(horizontal_start_limit_snake[3]), .vertical_start_limit(vertical_start_limit_snake[3]), .clk(clk), .isactive(isactive_snake_2), .address_write(address_write_wire[24]), .data_write(data_write_wire[24]));
    
    Snake_Part #
    ( .color(4),.offset(1), .number_of_fsm(1), .index(4))
    Snake_part_4
    ( .horizontal_start_limit(horizontal_start_limit_snake[4]), .vertical_start_limit(vertical_start_limit_snake[4]), .clk(clk), .isactive(isactive_snake_3), .address_write(address_write_wire[25]), .data_write(data_write_wire[25]));
    
    Snake_Part #
    ( .color(4),.offset(1), .number_of_fsm(1), .index(5))
    Snake_part_5
    ( .horizontal_start_limit(horizontal_start_limit_snake[5]), .vertical_start_limit(vertical_start_limit_snake[5]), .clk(clk), .isactive(isactive_snake_4), .address_write(address_write_wire[26]), .data_write(data_write_wire[26]));
    
    Snake_Part #
    ( .color(4),.offset(1), .number_of_fsm(1), .index(6))
    Snake_part_6
    ( .horizontal_start_limit(horizontal_start_limit_snake[6]), .vertical_start_limit(vertical_start_limit_snake[6]), .clk(clk), .isactive(isactive_snake_5), .address_write(address_write_wire[27]), .data_write(data_write_wire[27]));
    
    Snake_Part #
    ( .color(4),.offset(1), .number_of_fsm(1), .index(7))
    Snake_part_7
    ( .horizontal_start_limit(horizontal_start_limit_snake[7]), .vertical_start_limit(vertical_start_limit_snake[7]), .clk(clk), .isactive(isactive_snake_6), .address_write(address_write_wire[28]), .data_write(data_write_wire[28]));
    
    Snake_Part #
    ( .color(4),.offset(1), .number_of_fsm(1), .index(8))
    Snake_part_8
    ( .horizontal_start_limit(horizontal_start_limit_snake[8]), .vertical_start_limit(vertical_start_limit_snake[8]), .clk(clk), .isactive(isactive_snake_7), .address_write(address_write_wire[29]), .data_write(data_write_wire[29]));
    
    Snake_Part #
    ( .color(4),.offset(1), .number_of_fsm(1), .index(9))
    Snake_part_9
    ( .horizontal_start_limit(horizontal_start_limit_snake[9]), .vertical_start_limit(vertical_start_limit_snake[9]), .clk(clk), .isactive(isactive_snake_8), .address_write(address_write_wire[30]), .data_write(data_write_wire[30]));
    
    Snake_Part #
    ( .color(4),.offset(1), .number_of_fsm(1), .index(10))
    Snake_part_10
    ( .horizontal_start_limit(horizontal_start_limit_snake[10]), .vertical_start_limit(vertical_start_limit_snake[10]), .clk(clk), .isactive(isactive_snake_9), .address_write(address_write_wire[31]), .data_write(data_write_wire[31]));

    // You Win Message
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(280), .vertical_start_limit(100), .color(2), .offset(21), .number_of_fsm(3))
    Y
    ( .clk(clk), .isactive(w_isactive_you_win), .address_write(address_write_wire[32]), .data_write(data_write_wire[32])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(330), .vertical_start_limit(100), .color(2), .offset(6), .number_of_fsm(4))
    O2
    ( .clk(clk), .isactive(w_isactive_you_win), .address_write(address_write_wire[33]), .data_write(data_write_wire[33])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(380), .vertical_start_limit(100), .color(2), .offset(22), .number_of_fsm(3))
    U
    ( .clk(clk), .isactive(w_isactive_you_win), .address_write(address_write_wire[34]), .data_write(data_write_wire[34])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(430), .vertical_start_limit(100), .color(2), .offset(23), .number_of_fsm(4))
    W
    ( .clk(clk), .isactive(w_isactive_you_win), .address_write(address_write_wire[35]), .data_write(data_write_wire[35])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(520), .vertical_start_limit(100), .color(2), .offset(14), .number_of_fsm(2))
    I
    ( .clk(clk), .isactive(w_isactive_you_win), .address_write(address_write_wire[36]), .data_write(data_write_wire[36])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(570), .vertical_start_limit(100), .color(2), .offset(7), .number_of_fsm(3))
    N
    ( .clk(clk), .isactive(w_isactive_you_win), .address_write(address_write_wire[37]), .data_write(data_write_wire[37])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(620), .vertical_start_limit(100), .color(2), .offset(19), .number_of_fsm(2))
    Exclamation_Sign
    ( .clk(clk), .isactive(w_isactive_you_win), .address_write(address_write_wire[38]), .data_write(data_write_wire[38])); 
    
    // You Lose Message 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(280), .vertical_start_limit(100), .color(2), .offset(21), .number_of_fsm(3))
    Y2
    ( .clk(clk), .isactive(w_isactive_you_lose), .address_write(address_write_wire[39]), .data_write(data_write_wire[39])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(330), .vertical_start_limit(100), .color(2), .offset(6), .number_of_fsm(4))
    O3
    ( .clk(clk), .isactive(w_isactive_you_lose), .address_write(address_write_wire[40]), .data_write(data_write_wire[40])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(380), .vertical_start_limit(100), .color(2), .offset(22), .number_of_fsm(3))
    U2
    ( .clk(clk), .isactive(w_isactive_you_lose), .address_write(address_write_wire[41]), .data_write(data_write_wire[41])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(430), .vertical_start_limit(100), .color(2), .offset(34), .number_of_fsm(2))
    L
    ( .clk(clk), .isactive(w_isactive_you_lose), .address_write(address_write_wire[42]), .data_write(data_write_wire[42])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(480), .vertical_start_limit(100), .color(2), .offset(6), .number_of_fsm(4))
    O4
    ( .clk(clk), .isactive(w_isactive_you_lose), .address_write(address_write_wire[43]), .data_write(data_write_wire[43])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(530), .vertical_start_limit(100), .color(2), .offset(9), .number_of_fsm(5))
    S2
    ( .clk(clk), .isactive(w_isactive_you_lose), .address_write(address_write_wire[44]), .data_write(data_write_wire[44])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(580), .vertical_start_limit(100), .color(2), .offset(12), .number_of_fsm(4))
    E2
    ( .clk(clk), .isactive(w_isactive_you_lose), .address_write(address_write_wire[45]), .data_write(data_write_wire[45])); 
    
    Draw_Symbol_Unparameterized #
    ( .horizontal_start_limit(630), .vertical_start_limit(100), .color(2), .offset(19), .number_of_fsm(2))
    Exclamation_Sign_2
    ( .clk(clk), .isactive(w_isactive_you_lose), .address_write(address_write_wire[46]), .data_write(data_write_wire[46])); 



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
