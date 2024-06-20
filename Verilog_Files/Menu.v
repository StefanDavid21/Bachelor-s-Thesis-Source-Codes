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
        

module Menu
    
    (
        input clk,
        //input  sel_f1, 
        //input  sel_f2, 
        //input  sel_f3,
        //input reset_menu,
        input isactive_lfsr, 
        input reset_lfsr, 
        input isactive_digit, 
        input reset_digit,
        input [7:0] ps2_data_out,
        input stand_for_pong, 
        input [3:0] paddle_movement,
        
        input reset_button_for_snake,
        input reset_button_for_pong,
        input reset_to_checkpoint_pong,
        
        input reset_forced_lfsr,
        input direction_left_forced,
        input isactive_digit_forced,
        
        input jump_dino_button, 
        input reset_dino_button,
        
        output [18:0] address_write,
        output [11:0] data_write, 
        output led_test, 
        output audio_snake,
        output audio_pong 
        
    );
    
// Data and wire declarations 
    
    wire clk_25Mhz;
    wire enable_v_counter; 
    wire [15:0] h_count_value; 
    wire [15:0] v_count_value; 

    parameter number_of_fsm = 6; 
    wire[11:0] data_write_wire[number_of_fsm-1 : 0];
    wire[18:0] address_write_wire[number_of_fsm-1 : 0];
    reg [18:0] address_test [number_of_fsm - 1 : 0]; 
    reg [11:0] data_test [number_of_fsm - 1 : 0];
    
    wire  w_hsynq_dino, w_vsynq_dino; 
    wire [3:0] w_red_dino, w_green_dino, w_blue_dino; 
    
    
    integer j;

// Modules for counting 
     
    clk_divider m0
    (
        .clk(clk), 
        .divided_clk(clk_25Mhz)      
    );
      
// Logic for keyboard input 

      localparam FRAME_1 = 3'b000, FRAME_2 = 3'b001, FRAME_3 = 3'b010, PONG = 3'b011, SNAKE = 3'b100, DINO = 3'b101;
      reg [2:0] current_frame; 
      reg [2:0] next_frame;
      wire sel_f1, sel_f2, sel_f3, sel_snake; 
      reg reset_menu_2;
      
      always@(posedge clk_25Mhz)
      
      begin
        if(ps2_data_out == 8'h2d) //esc
            current_frame <= FRAME_1; //pong selected
        
        else
            current_frame <= next_frame;  
      end
      
      always@(posedge clk_25Mhz)
      
      begin
        
            next_frame = current_frame; 
            
            case(current_frame)
                    
                    FRAME_1: begin if(ps2_data_out == 8'h1b) next_frame = FRAME_2; 
                                   else if(ps2_data_out == 8'h5a) next_frame = PONG; end
                                   
                    FRAME_2: begin if(ps2_data_out == 8'h1c) next_frame = FRAME_1;
                                   else if(ps2_data_out == 8'h1a) next_frame = FRAME_3;
                                   else if(ps2_data_out == 8'h5a) next_frame = SNAKE; end
                                   
                    FRAME_3: begin if(ps2_data_out == 8'h1b) next_frame = FRAME_2;
                                   else if(ps2_data_out == 8'h5a) next_frame = DINO; end
                                   
                    PONG: begin    if(ps2_data_out == 8'h76) next_frame = FRAME_1; end
                    
                    SNAKE: begin   if(ps2_data_out == 8'h76) next_frame = FRAME_2; end
                    
                    DINO: begin if(ps2_data_out == 8'h76) next_frame = FRAME_3; end
                    
                    default: next_frame = FRAME_1; 
                
            endcase 
      end
      
      
      
      assign sel_f1 = (current_frame == FRAME_1);
      assign sel_f2 = (current_frame == FRAME_2);  
      assign sel_f3 = (current_frame == FRAME_3);  
      assign sel_pong = (current_frame == PONG); 
      assign sel_snake = (current_frame == SNAKE);
      assign sel_dino = (current_frame == DINO); 

   
    
// Instantiate The Frames   

    Draw_Frame # 

    (
        .select(1), 
        .number_of_fsm(26) 
    )
     Frame_1
    (
        .clk(clk),
        .isactive(sel_f1),
        
        .address_write(address_write_wire[0]),
        .data_write(data_write_wire[0])
    );
    
    Draw_Frame # 

    (
        .select(2),       
        .number_of_fsm(26) 
    )
     Frame_2
    (
        .clk(clk),
        .isactive(sel_f2),
        
        .address_write(address_write_wire[1]),
        .data_write(data_write_wire[1])
    );
    
    Draw_Frame # 

    (
        .select(3),
        .number_of_fsm(26) 
    )
     Frame_3
    (
        .clk(clk),
        .isactive(sel_f3),
        
        .address_write(address_write_wire[2]),
        .data_write(data_write_wire[2])
    );

    
     Snake_Top SNAKE_GAME
    (
        
        .clk(clk),
        .isactive(sel_snake),
        .ps2_data_out(ps2_data_out),
        .reset_button_for_snake(reset_button_for_snake),
        .reset_forced_lfsr(reset_forced_lfsr),        
        .direction_left_forced(direction_left_forced),
        .isactive_digit_forced(isactive_digit_forced),
        
        .address_write(address_write_wire[3]),
        .data_write(data_write_wire[3]), 
        .led_test(led_test),
        .audio_snake(audio_snake)

    );
    
     Pong_Top PONG_GAME
    (
        .clk(clk),               
        .isactive(sel_pong),          
        .ps2_data_out(ps2_data_out),
        .reset_to_start_pong(reset_button_for_pong),
        .reset_to_checkpoint_pong(reset_to_checkpoint_pong),
        .stand(stand_for_pong), 
        .paddle_movement(paddle_movement), 
        
        .address_write(address_write_wire[4]),
        .data_write(data_write_wire[4]),
        .audio_pong(audio_pong)
    );
    
     Dino_Top DINO_GAME
     (
        .clk(clk),
        .button(jump_dino_button),
        .debug(reset_dino_button),
        .isactive(sel_dino),
        .hsync(),
        .vsync(),
        .red(),
        .green(),
        .blue(), 
        .address_write(address_write_wire[5]),
        .data_write(data_write_wire[5])
    );

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
  //assign data_write = data_test[number_of_fsm - 1]; 
  
  assign data_write = (sel_f1) ? data_write_wire[0] : (sel_f2) ? data_write_wire[1] : (sel_f3) ? data_write_wire[2] : (sel_snake) ? data_write_wire[3] : (sel_pong) ? data_write_wire[4] : data_write_wire[5];                          
endmodule
