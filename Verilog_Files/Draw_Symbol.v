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

module Draw_Symbol #
    (     
        parameter horizontal_start_limit = 1,
        parameter vertical_start_limit = 1,
        parameter color = 4,
        parameter offset = 1, 
        parameter isactive = 1,
        parameter number_of_fsm = 16
         
    )
    
    (
        input clk, 
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


// Alphabet

    generate
    
    case(offset)
                
     1:   //M High
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 60), .color(color))
        /*Name of Instance*/ m77
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Left_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 60), .vertical_end_limit(vertical_start_limit + 60), .color(color), .width(2))
        /*Name of Instance*/ m78
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));
        
        Draw_FSM_Right_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 60), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 120), .vertical_end_limit(vertical_start_limit + 60), .color(color), .width(2))
        /*Name of Instance*/ m79
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 120), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 120), .vertical_end_limit(vertical_start_limit + 60), .color(color))
        /*Name of Instance*/ m775
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
    
     end                
         
     2: // E high
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 60), .color(color))
        /*Name of Instance*/ m77
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 60), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m78
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 30), .horizontal_end_limit(horizontal_start_limit + 60), .vertical_end_limit(vertical_start_limit + 30), .color(color))
        /*Name of Instance*/ m772
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 60), .horizontal_end_limit(horizontal_start_limit + 60), .vertical_end_limit(vertical_start_limit + 60), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
          
     end 
     
     3: // N high
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 60), .color(color))
        /*Name of Instance*/ m77
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
         Draw_FSM_Left_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 60), .vertical_end_limit(vertical_start_limit + 60), .color(color), .width(2))
        /*Name of Instance*/ m78
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 60), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 60), .vertical_end_limit(vertical_start_limit + 60), .color(color))
        /*Name of Instance*/ m772
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
     
     end
     
     4: // U high
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 60), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 60), .horizontal_end_limit(horizontal_start_limit + 60), .vertical_end_limit(vertical_start_limit + 60), .color(color))
        /*Name of Instance*/ m772
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 60), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 60), .vertical_end_limit(vertical_start_limit + 60), .color(color))
        /*Name of Instance*/ m773
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
     end
     
     5: // P 
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m772
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m773
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m774
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
        
     end 
     
     6: // O
     begin
        
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m772
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 40), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m773
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m774
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
        
     
     end
     
     7: // N
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m77
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
         Draw_FSM_Left_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color), .width(2))
        /*Name of Instance*/ m78
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 40), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m772
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
     
     end
     
     8: // G
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m772
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m773
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 40), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m774
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 35), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 45), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m777
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[4]), .data_out(data_write_wire[4]));   
        
     
     end
     
     9: // S
     begin
     
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m772
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m773
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 40), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m774
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m777
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[4]), .data_out(data_write_wire[4]));   
        
     
     end 
         
     10: // A 
     
     begin
     
         Draw_FSM_Right_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color), .width(2))
        /*Name of Instance*/ m79
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));
        
        Draw_FSM_Left_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit+40), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 80), .vertical_end_limit(vertical_start_limit + 40), .color(color), .width(2))
        /*Name of Instance*/ m78
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));
        
         Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 60), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m77
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
         
     end
     
     11: //K
     
     begin
     
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Right_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color), .width(2))
        /*Name of Instance*/ m79
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));
        
        Draw_FSM_Left_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color), .width(2))
        /*Name of Instance*/ m78
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));

     end
     
     12: //E 
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m77
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m78
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m772
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
         
     
     end
     
     13: //C
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m77
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m78
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
         
     
     end 
     
     14: //I
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m77
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit + 3), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m773
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
     end
     
     15: //V
     begin
        
        Draw_FSM_Left_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color), .width(2))
        /*Name of Instance*/ m78
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));
        
        Draw_FSM_Right_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 40), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 80), .vertical_end_limit(vertical_start_limit + 40), .color(color), .width(2))
        /*Name of Instance*/ m79
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));
          
     end
     
     16: //D 
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 40), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m77
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m78
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m772
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
         
        
     end
     
     17: //R
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m772
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m773
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m774
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
        
        Draw_FSM_Left_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color), .width(2))
        /*Name of Instance*/ m78
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[4]), .data_out(data_write_wire[4]));

     end
     
     18: //Arrow
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m774
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Left_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 20), .color(color), .width(2))
        /*Name of Instance*/ m78
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));
        
        Draw_FSM_Right_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color), .width(2))
        /*Name of Instance*/ m79
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));
         
     end
     
     19: //! 
     
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 32), .color(color))
        /*Name of Instance*/ m77
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 21), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 21), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m773
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
     end
     
     20: // : 
     begin 
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit + 10), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 10), .color(color))
        /*Name of Instance*/ m77
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit + 30), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 30), .color(color))
        /*Name of Instance*/ m773
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
     end 
     
     21: // Y 
     begin 
        
        Draw_FSM_Left_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color), .width(2))
        /*Name of Instance*/ m78
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));
        
        Draw_FSM_Right_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 20), .color(color), .width(2))
        /*Name of Instance*/ m79
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m77
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
     
     end
     
     22: //U
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m772
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m773
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
     end
     
     23: //W 
     begin
        
        Draw_FSM_Left_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 40), .vertical_end_limit(vertical_start_limit + 40), .color(color), .width(2))
        /*Name of Instance*/ m78
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));
        
        Draw_FSM_Right_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 40), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 80), .vertical_end_limit(vertical_start_limit + 40), .color(color), .width(2))
        /*Name of Instance*/ m79
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));
        
        Draw_FSM_Left_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 60), .vertical_end_limit(vertical_start_limit + 40), .color(color), .width(2))
        /*Name of Instance*/ m782
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));
        
        Draw_FSM_Right_Diagonal # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 60), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 100), .vertical_end_limit(vertical_start_limit + 40), .color(color), .width(2))
        /*Name of Instance*/ m794
        /* I/O Connection*/(.clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));
        
        
     end
     
     24: // 0  
     begin
     
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7712
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7713
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40 ), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7715
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
       
     end
     
     25: // 1
     begin 
     
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));        
     
     end
     
     26: // 2 
     begin 
     
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m7712
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m7713
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7715
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7714
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[4]), .data_out(data_write_wire[4]));   
        
     end 
     
     27: // 3 
     begin 
     
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m7713
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7714
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7715
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
         
     end 
     
     28: // 4
     begin
     
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7714
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m7715
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
              
     end
     
     29: //5 
     begin 
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m7712
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m7713
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7715
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7716
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[4]), .data_out(data_write_wire[4]));   

     end
     
     30: // 6 
     begin 
     
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7714
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m7715
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7716
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m77161
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[4]), .data_out(data_write_wire[4]));   
  
     end
     
     31: // 7
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7712
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
     end 
     
     32: // 8 
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m7714
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7715
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7716
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7719
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[4]), .data_out(data_write_wire[4]));   
        
     end
     
     33: // 9
     begin
     
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit), .color(color))
        /*Name of Instance*/ m771
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m7715
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 20), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 20), .color(color))
        /*Name of Instance*/ m7716
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[2]), .data_out(data_write_wire[2]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit + 20), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m77111
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[3]), .data_out(data_write_wire[3]));   
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m77142
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[4]), .data_out(data_write_wire[4]));   
              
     end
     
     34: // L
     begin
        
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit), .horizontal_end_limit(horizontal_start_limit), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m7716
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[0]), .data_out(data_write_wire[0]));   
         
        Draw_FSM_Rectangle # 
        /*Parameter*/ (.horizontal_start_limit(horizontal_start_limit), .vertical_start_limit(vertical_start_limit + 40), .horizontal_end_limit(horizontal_start_limit + 20), .vertical_end_limit(vertical_start_limit + 40), .color(color))
        /*Name of Instance*/ m77164
        /* I/O Connection*/ ( .clk(clk_25Mhz), .horizontal_actual_position(h_count_value), .vertical_actual_position(v_count_value), .addr(address_write_wire[1]), .data_out(data_write_wire[1]));   
          
     end
                                 
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
