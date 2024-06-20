`timescale 1ns / 1ps

/*  Fa instante de module pentru desen doar cu pixeli care se afiseaza pe ecran
     Adica: 
        Primul pixel din coltul stanga sus de pe ecran va fi cu coord: Horizontal: 144 Vertical: 35
        Ultimul pixel din coltul dreapta sus va avea coord: Horizontal: 783 Vertical: 35
        Primul pixel din coltul stanga jos va avea coord: Horizontal: 144 Vertical: 514
        Ultimul pixel din coltul dreapta jos va avea coord: Horizontal: 783 Vertical: 514 */ 
 
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
       
 */       
        

module Draw_Frame # 

    (
        parameter select = 0,
        parameter number_of_fsm = 20 
    )
    
    (
        input clk,
        input isactive,
        
        output [18:0] address_write,
        output [11:0] data_write
    );
    
// Data and wire declarations 
    
    wire clk_25Mhz;
    wire enable_v_counter; 
    wire [15:0] h_count_value; 
    wire [15:0] v_count_value; 
 
    wire[11:0] data_write_wire[number_of_fsm-1 : 0];
    wire[18:0] address_write_wire[number_of_fsm-1 : 0];
    reg [18:0] address_test [number_of_fsm - 1 : 0]; 
    reg [11:0] data_test [number_of_fsm - 1 : 0];
    
    integer j;

// Modules for counting 
     
    clk_divider m0
    (
        .clk(clk), 
        .divided_clk(clk_25Mhz)      
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
    
// Instantiate The Frames   

    generate 
    
        case(select)
        
        1:  //Frame 1 Pong Selected
            begin 
                
                // Border 
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(144), .vertical_start_limit(35), .horizontal_end_limit(783), .vertical_end_limit(50), .color(2))
                /*Name of Instance*/ Up_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(144), .vertical_start_limit(499), .horizontal_end_limit(783), .vertical_end_limit(514), .color(2))
                /*Name of Instance*/ Down_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(144), .vertical_start_limit(35), .horizontal_end_limit(164), .vertical_end_limit(514), .color(2))
                /*Name of Instance*/ Left_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(763), .vertical_start_limit(35), .horizontal_end_limit(783), .vertical_end_limit(514), .color(2))
                /*Name of Instance*/ Right_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
                
                
                
                
                
                // MENU TITLE
                
                Draw_Symbol #
                ( .horizontal_start_limit(284), .vertical_start_limit(70), .color(2), .offset(1), .isactive(1), .number_of_fsm(4))
                M_high
                ( .clk(clk), .address_write(address_write_wire[4]), .data_write(data_write_wire[4]));
             
                Draw_Symbol #
                ( .horizontal_start_limit(424), .vertical_start_limit(70), .color(2), .offset(2), .isactive(1), .number_of_fsm(4))
                E_high
                ( .clk(clk), .address_write(address_write_wire[5]), .data_write(data_write_wire[5]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(504), .vertical_start_limit(70), .color(2), .offset(3), .isactive(1), .number_of_fsm(3))
                N_high
                ( .clk(clk), .address_write(address_write_wire[6]), .data_write(data_write_wire[6]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(580), .vertical_start_limit(70), .color(2), .offset(4), .isactive(1), .number_of_fsm(3))
                U_high
                ( .clk(clk), .address_write(address_write_wire[7]), .data_write(data_write_wire[7]));
             
                
                // Pong
                
                Draw_Symbol #
                ( .horizontal_start_limit(354), .vertical_start_limit(200), .color(2), .offset(5), .isactive(1), .number_of_fsm(4))
                P
                ( .clk(clk), .address_write(address_write_wire[8]), .data_write(data_write_wire[8]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(404), .vertical_start_limit(200), .color(2), .offset(6), .isactive(1), .number_of_fsm(4))
                O
                ( .clk(clk), .address_write(address_write_wire[9]), .data_write(data_write_wire[9])); 
                
                Draw_Symbol #
                ( .horizontal_start_limit(474), .vertical_start_limit(200), .color(2), .offset(7), .isactive(1), .number_of_fsm(3))
                N
                ( .clk(clk), .address_write(address_write_wire[10]), .data_write(data_write_wire[10]));
             
                Draw_Symbol #
                ( .horizontal_start_limit(534), .vertical_start_limit(200), .color(2), .offset(8), .isactive(1), .number_of_fsm(5))
                G
                ( .clk(clk), .address_write(address_write_wire[11]), .data_write(data_write_wire[11]));   
                
                
                
                // Snake
                
                Draw_Symbol #
                ( .horizontal_start_limit(324), .vertical_start_limit(300), .color(2), .offset(9), .isactive(1), .number_of_fsm(5))
                S
                ( .clk(clk), .address_write(address_write_wire[12]), .data_write(data_write_wire[12])); 
                
                Draw_Symbol #
                ( .horizontal_start_limit(384), .vertical_start_limit(300), .color(2), .offset(7), .isactive(1), .number_of_fsm(3))
                N2
                ( .clk(clk), .address_write(address_write_wire[13]), .data_write(data_write_wire[13]));
             
                Draw_Symbol #
                ( .horizontal_start_limit(430), .vertical_start_limit(300), .color(2), .offset(10), .isactive(1), .number_of_fsm(3))
                A
                ( .clk(clk), .address_write(address_write_wire[14]), .data_write(data_write_wire[14]));
                
                Draw_Symbol #
                ( .horizontal_start_limit(520), .vertical_start_limit(300), .color(2), .offset(11), .isactive(1), .number_of_fsm(3))
                K
                ( .clk(clk), .address_write(address_write_wire[15]), .data_write(data_write_wire[15]));   

                Draw_Symbol #
                ( .horizontal_start_limit(564), .vertical_start_limit(300), .color(2), .offset(12), .isactive(1), .number_of_fsm(4))
                E
                ( .clk(clk), .address_write(address_write_wire[16]), .data_write(data_write_wire[16])); 
                
                
                // Dino
                
                Draw_Symbol #
                ( .horizontal_start_limit(344), .vertical_start_limit(400), .color(2), .offset(16), .isactive(1), .number_of_fsm(4))
                D
                ( .clk(clk), .address_write(address_write_wire[17]), .data_write(data_write_wire[17]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(404), .vertical_start_limit(400), .color(2), .offset(14), .isactive(1), .number_of_fsm(2))
                I
                ( .clk(clk), .address_write(address_write_wire[18]), .data_write(data_write_wire[18])); 
                
                Draw_Symbol #
                ( .horizontal_start_limit(474), .vertical_start_limit(400), .color(2), .offset(7), .isactive(1), .number_of_fsm(3))
                N_2
                ( .clk(clk), .address_write(address_write_wire[19]), .data_write(data_write_wire[19]));
             
                Draw_Symbol #
                ( .horizontal_start_limit(534), .vertical_start_limit(400), .color(2), .offset(6), .isactive(1), .number_of_fsm(4))
                O_2
                ( .clk(clk), .address_write(address_write_wire[20]), .data_write(data_write_wire[20])); 
                
                
                
                // Arrow + Selection Cassette
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(334), .vertical_start_limit(180), .horizontal_end_limit(594), .vertical_end_limit(190), .color(2))
                /*Name of Instance*/ Up_Border_2
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[21]), .data_out(data_write_wire[21]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(334), .vertical_start_limit(250), .horizontal_end_limit(594), .vertical_end_limit(260), .color(2))
                /*Name of Instance*/ Down_Border_2
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[22]), .data_out(data_write_wire[22]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(334), .vertical_start_limit(180), .horizontal_end_limit(344), .vertical_end_limit(260), .color(2))
                /*Name of Instance*/ Left_Border_2
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[23]), .data_out(data_write_wire[23]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(584), .vertical_start_limit(180), .horizontal_end_limit(594), .vertical_end_limit(260), .color(2))
                /*Name of Instance*/ Right_Border_2
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[24]), .data_out(data_write_wire[24]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(284), .vertical_start_limit(200), .color(2), .offset(18), .isactive(1), .number_of_fsm(3))
                Arrow
                ( .clk(clk), .address_write(address_write_wire[25]), .data_write(data_write_wire[25])); 
                    
            end
            
        2: //Frame 2 Snake Selected
            begin 
                
                // Border 
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(144), .vertical_start_limit(35), .horizontal_end_limit(783), .vertical_end_limit(50), .color(2))
                /*Name of Instance*/ Up_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(144), .vertical_start_limit(499), .horizontal_end_limit(783), .vertical_end_limit(514), .color(2))
                /*Name of Instance*/ Down_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(144), .vertical_start_limit(35), .horizontal_end_limit(164), .vertical_end_limit(514), .color(2))
                /*Name of Instance*/ Left_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(763), .vertical_start_limit(35), .horizontal_end_limit(783), .vertical_end_limit(514), .color(2))
                /*Name of Instance*/ Right_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
                
                
                
                
                
                // MENU TITLE
                
                Draw_Symbol #
                ( .horizontal_start_limit(284), .vertical_start_limit(70), .color(2), .offset(1), .isactive(1), .number_of_fsm(4))
                M_high
                ( .clk(clk), .address_write(address_write_wire[4]), .data_write(data_write_wire[4]));
             
                Draw_Symbol #
                ( .horizontal_start_limit(424), .vertical_start_limit(70), .color(2), .offset(2), .isactive(1), .number_of_fsm(4))
                E_high
                ( .clk(clk), .address_write(address_write_wire[5]), .data_write(data_write_wire[5]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(504), .vertical_start_limit(70), .color(2), .offset(3), .isactive(1), .number_of_fsm(3))
                N_high
                ( .clk(clk), .address_write(address_write_wire[6]), .data_write(data_write_wire[6]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(580), .vertical_start_limit(70), .color(2), .offset(4), .isactive(1), .number_of_fsm(3))
                U_high
                ( .clk(clk), .address_write(address_write_wire[7]), .data_write(data_write_wire[7]));
             
                
                // Pong
                
                Draw_Symbol #
                ( .horizontal_start_limit(354), .vertical_start_limit(200), .color(2), .offset(5), .isactive(1), .number_of_fsm(4))
                P
                ( .clk(clk), .address_write(address_write_wire[8]), .data_write(data_write_wire[8]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(404), .vertical_start_limit(200), .color(2), .offset(6), .isactive(1), .number_of_fsm(4))
                O
                ( .clk(clk), .address_write(address_write_wire[9]), .data_write(data_write_wire[9])); 
                
                Draw_Symbol #
                ( .horizontal_start_limit(474), .vertical_start_limit(200), .color(2), .offset(7), .isactive(1), .number_of_fsm(3))
                N
                ( .clk(clk), .address_write(address_write_wire[10]), .data_write(data_write_wire[10]));
             
                Draw_Symbol #
                ( .horizontal_start_limit(534), .vertical_start_limit(200), .color(2), .offset(8), .isactive(1), .number_of_fsm(5))
                G
                ( .clk(clk), .address_write(address_write_wire[11]), .data_write(data_write_wire[11]));   
                
                
                
                // Snake
                
                Draw_Symbol #
                ( .horizontal_start_limit(324), .vertical_start_limit(300), .color(2), .offset(9), .isactive(1), .number_of_fsm(5))
                S
                ( .clk(clk), .address_write(address_write_wire[12]), .data_write(data_write_wire[12])); 
                
                Draw_Symbol #
                ( .horizontal_start_limit(384), .vertical_start_limit(300), .color(2), .offset(7), .isactive(1), .number_of_fsm(3))
                N2
                ( .clk(clk), .address_write(address_write_wire[13]), .data_write(data_write_wire[13]));
             
                Draw_Symbol #
                ( .horizontal_start_limit(430), .vertical_start_limit(300), .color(2), .offset(10), .isactive(1), .number_of_fsm(3))
                A
                ( .clk(clk), .address_write(address_write_wire[14]), .data_write(data_write_wire[14]));
                
                Draw_Symbol #
                ( .horizontal_start_limit(520), .vertical_start_limit(300), .color(2), .offset(11), .isactive(1), .number_of_fsm(3))
                K
                ( .clk(clk), .address_write(address_write_wire[15]), .data_write(data_write_wire[15]));   

                Draw_Symbol #
                ( .horizontal_start_limit(564), .vertical_start_limit(300), .color(2), .offset(12), .isactive(1), .number_of_fsm(4))
                E
                ( .clk(clk), .address_write(address_write_wire[16]), .data_write(data_write_wire[16])); 
                
                
                // Dino
                
                Draw_Symbol #
                ( .horizontal_start_limit(344), .vertical_start_limit(400), .color(2), .offset(16), .isactive(1), .number_of_fsm(4))
                D
                ( .clk(clk), .address_write(address_write_wire[17]), .data_write(data_write_wire[17]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(404), .vertical_start_limit(400), .color(2), .offset(14), .isactive(1), .number_of_fsm(2))
                I
                ( .clk(clk), .address_write(address_write_wire[18]), .data_write(data_write_wire[18])); 
                
                Draw_Symbol #
                ( .horizontal_start_limit(474), .vertical_start_limit(400), .color(2), .offset(7), .isactive(1), .number_of_fsm(3))
                N_2
                ( .clk(clk), .address_write(address_write_wire[19]), .data_write(data_write_wire[19]));
             
                Draw_Symbol #
                ( .horizontal_start_limit(534), .vertical_start_limit(400), .color(2), .offset(6), .isactive(1), .number_of_fsm(4))
                O_2
                ( .clk(clk), .address_write(address_write_wire[20]), .data_write(data_write_wire[20]));
                
                
                // Arrow + Selection Cassette
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(314), .vertical_start_limit(280), .horizontal_end_limit(624), .vertical_end_limit(290), .color(2))
                /*Name of Instance*/ Up_Border_2
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[21]), .data_out(data_write_wire[21]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(314), .vertical_start_limit(350), .horizontal_end_limit(624), .vertical_end_limit(360), .color(2))
                /*Name of Instance*/ Down_Border_2
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[22]), .data_out(data_write_wire[22]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(314), .vertical_start_limit(280), .horizontal_end_limit(320), .vertical_end_limit(360), .color(2))
                /*Name of Instance*/ Left_Border_2
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[23]), .data_out(data_write_wire[23]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(618), .vertical_start_limit(280), .horizontal_end_limit(624), .vertical_end_limit(360), .color(2))
                /*Name of Instance*/ Right_Border_2
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[24]), .data_out(data_write_wire[24]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(264), .vertical_start_limit(300), .color(2), .offset(18), .isactive(1), .number_of_fsm(3))
                Arrow
                ( .clk(clk), .address_write(address_write_wire[25]), .data_write(data_write_wire[25])); 
                
        
           end
           
        3: // Frame 3 Space Invaders Selected
            begin
                
                // Border 
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(144), .vertical_start_limit(35), .horizontal_end_limit(783), .vertical_end_limit(50), .color(2))
                /*Name of Instance*/ Up_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(144), .vertical_start_limit(499), .horizontal_end_limit(783), .vertical_end_limit(514), .color(2))
                /*Name of Instance*/ Down_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(144), .vertical_start_limit(35), .horizontal_end_limit(164), .vertical_end_limit(514), .color(2))
                /*Name of Instance*/ Left_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(763), .vertical_start_limit(35), .horizontal_end_limit(783), .vertical_end_limit(514), .color(2))
                /*Name of Instance*/ Right_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
                
                
                
                
                
                // MENU TITLE
                
                Draw_Symbol #
                ( .horizontal_start_limit(284), .vertical_start_limit(70), .color(2), .offset(1), .isactive(1), .number_of_fsm(4))
                M_high
                ( .clk(clk), .address_write(address_write_wire[4]), .data_write(data_write_wire[4]));
             
                Draw_Symbol #
                ( .horizontal_start_limit(424), .vertical_start_limit(70), .color(2), .offset(2), .isactive(1), .number_of_fsm(4))
                E_high
                ( .clk(clk), .address_write(address_write_wire[5]), .data_write(data_write_wire[5]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(504), .vertical_start_limit(70), .color(2), .offset(3), .isactive(1), .number_of_fsm(3))
                N_high
                ( .clk(clk), .address_write(address_write_wire[6]), .data_write(data_write_wire[6]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(580), .vertical_start_limit(70), .color(2), .offset(4), .isactive(1), .number_of_fsm(3))
                U_high
                ( .clk(clk), .address_write(address_write_wire[7]), .data_write(data_write_wire[7]));
             
                
                // Pong
                
                Draw_Symbol #
                ( .horizontal_start_limit(354), .vertical_start_limit(200), .color(2), .offset(5), .isactive(1), .number_of_fsm(4))
                P
                ( .clk(clk), .address_write(address_write_wire[8]), .data_write(data_write_wire[8]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(404), .vertical_start_limit(200), .color(2), .offset(6), .isactive(1), .number_of_fsm(4))
                O
                ( .clk(clk), .address_write(address_write_wire[9]), .data_write(data_write_wire[9])); 
                
                Draw_Symbol #
                ( .horizontal_start_limit(474), .vertical_start_limit(200), .color(2), .offset(7), .isactive(1), .number_of_fsm(3))
                N
                ( .clk(clk), .address_write(address_write_wire[10]), .data_write(data_write_wire[10]));
             
                Draw_Symbol #
                ( .horizontal_start_limit(534), .vertical_start_limit(200), .color(2), .offset(8), .isactive(1), .number_of_fsm(5))
                G
                ( .clk(clk), .address_write(address_write_wire[11]), .data_write(data_write_wire[11]));   
                
                
                
                // Snake
                
                Draw_Symbol #
                ( .horizontal_start_limit(324), .vertical_start_limit(300), .color(2), .offset(9), .isactive(1), .number_of_fsm(5))
                S
                ( .clk(clk), .address_write(address_write_wire[12]), .data_write(data_write_wire[12])); 
                
                Draw_Symbol #
                ( .horizontal_start_limit(384), .vertical_start_limit(300), .color(2), .offset(7), .isactive(1), .number_of_fsm(3))
                N2
                ( .clk(clk), .address_write(address_write_wire[13]), .data_write(data_write_wire[13]));
             
                Draw_Symbol #
                ( .horizontal_start_limit(430), .vertical_start_limit(300), .color(2), .offset(10), .isactive(1), .number_of_fsm(3))
                A
                ( .clk(clk), .address_write(address_write_wire[14]), .data_write(data_write_wire[14]));
                
                Draw_Symbol #
                ( .horizontal_start_limit(520), .vertical_start_limit(300), .color(2), .offset(11), .isactive(1), .number_of_fsm(3))
                K
                ( .clk(clk), .address_write(address_write_wire[15]), .data_write(data_write_wire[15]));   

                Draw_Symbol #
                ( .horizontal_start_limit(564), .vertical_start_limit(300), .color(2), .offset(12), .isactive(1), .number_of_fsm(4))
                E
                ( .clk(clk), .address_write(address_write_wire[16]), .data_write(data_write_wire[16])); 
                
                
                // Dino
                
                Draw_Symbol #
                ( .horizontal_start_limit(344), .vertical_start_limit(400), .color(2), .offset(16), .isactive(1), .number_of_fsm(4))
                D
                ( .clk(clk), .address_write(address_write_wire[17]), .data_write(data_write_wire[17]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(404), .vertical_start_limit(400), .color(2), .offset(14), .isactive(1), .number_of_fsm(2))
                I
                ( .clk(clk), .address_write(address_write_wire[18]), .data_write(data_write_wire[18])); 
                
                Draw_Symbol #
                ( .horizontal_start_limit(474), .vertical_start_limit(400), .color(2), .offset(7), .isactive(1), .number_of_fsm(3))
                N_2
                ( .clk(clk), .address_write(address_write_wire[19]), .data_write(data_write_wire[19]));
             
                Draw_Symbol #
                ( .horizontal_start_limit(534), .vertical_start_limit(400), .color(2), .offset(6), .isactive(1), .number_of_fsm(4))
                O_2
                ( .clk(clk), .address_write(address_write_wire[20]), .data_write(data_write_wire[20])); 
                
                
                
                // Arrow + Selection Cassette
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(334), .vertical_start_limit(380), .horizontal_end_limit(594), .vertical_end_limit(390), .color(2))
                /*Name of Instance*/ Up_Border_2
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[21]), .data_out(data_write_wire[21]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(334), .vertical_start_limit(450), .horizontal_end_limit(594), .vertical_end_limit(460), .color(2))
                /*Name of Instance*/ Down_Border_2
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[22]), .data_out(data_write_wire[22]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(334), .vertical_start_limit(380), .horizontal_end_limit(344), .vertical_end_limit(460), .color(2))
                /*Name of Instance*/ Left_Border_2
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[23]), .data_out(data_write_wire[23]));   
                
                Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(584), .vertical_start_limit(380), .horizontal_end_limit(594), .vertical_end_limit(460), .color(2))
                /*Name of Instance*/ Right_Border_2
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[24]), .data_out(data_write_wire[24]));   
                
                Draw_Symbol #
                ( .horizontal_start_limit(284), .vertical_start_limit(400), .color(2), .offset(18), .isactive(1), .number_of_fsm(3))
                Arrow
                ( .clk(clk), .address_write(address_write_wire[25]), .data_write(data_write_wire[25])); 
                
        
           end       
           
           4:   Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(144), .vertical_start_limit(35), .horizontal_end_limit(783), .vertical_end_limit(50), .color(1))
                /*Name of Instance*/ Up_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
           
           5: Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(144), .vertical_start_limit(35), .horizontal_end_limit(783), .vertical_end_limit(50), .color(2))
                /*Name of Instance*/ Up_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
           
           6: Draw_FSM_Rectangle # 
                /*Parameter*/ (.horizontal_start_limit(144), .vertical_start_limit(35), .horizontal_end_limit(783), .vertical_end_limit(50), .color(3))
                /*Name of Instance*/ Up_Border
                /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
                          
        
        endcase
    
    endgenerate
  
    

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
