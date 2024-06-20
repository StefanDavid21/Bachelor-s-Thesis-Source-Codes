module Snake_Game_Logic_Menu
    (
        input clk,
        
        input [7:0] ps2_data_out,
        input reset,
        
        input isactive_digit9,
        input direction_left_forced, 
        
        input [15:0] lfsr_horizontal_coord, 
        input [15:0] lfsr_vertical_coord,
              
        output [10:0] head_modified_position_horizontal,
        output [10:0] head_modified_position_vertical, 
        
        output isactive_you_win, 
        output isactive_you_lose,
        
        output count_increment_score, 
        output isactive_lfsr, 
        
        output reset_lfsr,
        output reset_digit_sanki, 
        
        output reg led_test
    );
    
//Se asociaza sirurilor de biti folositi pentru codarea starilor nume ce pot fi folosite mai usor in cod.
//La compilare, numele vor fi inlocuite in cod cu numerele asociate la inceput.
localparam START = 2'b00;
localparam GAME = 2'b01;
localparam WIN = 2'b10;
localparam LOSE = 2'b11;

reg led_test_2;
reg [10:0] head_coord_horizontal, head_coord_vertical; 
reg direction_up, direction_down, direction_left, direction_right, stand; 
reg [1:0] state, state_next;
reg isactive_youwin, isactive_youlose;
reg reset_to_start; 
reg reset_digit, isactive_digit; 
reg count_increment_score_sanki;
reg isactive_lfsr_reset_sanki; 
reg reset_lfsr_sanki;
reg [2:0] direction; 



always@(posedge clk) begin
    // Logica pentru direc?ia ?arpelui bazatã pe intrãrile tastaturii
    case(ps2_data_out)
        8'h05: led_test_2 <= 1;
        8'h01: direction <= 3'b010; //Force direction
        8'h43: direction <= 3'b000; // I pentru direc?ia sus
        8'h42: direction <= 3'b001; // K pentru direc?ia jos
        8'h3B: direction <= 3'b010; // J pentru direc?ia stânga
        8'h4B: direction <= 3'b011; // L pentru direc?ia dreapta
        8'h4D: reset_to_start <= 1; // P pentru resetarea la început 
        default: direction <= direction; // Men?ine direc?ia anterioarã dacã nu s-a apãsat nicio tastã
    endcase
end


always@(posedge clk) 
begin 
    
    if (stand) 
        begin
            head_coord_horizontal <= 470;
            head_coord_vertical <= 300;      
        end
    else
        begin
            case(direction)
    
                3'b000: begin 
                            head_coord_vertical <= head_coord_vertical - 10; // Sus
                            head_coord_horizontal <= head_coord_horizontal;
                       end     
                       
                3'b001: begin
                            head_coord_vertical <= head_coord_vertical + 10; // Jos
                            head_coord_horizontal <= head_coord_horizontal;
                       end     
                
                3'b010: begin 
                            head_coord_horizontal <= head_coord_horizontal - 10; // Stânga
                            head_coord_vertical <= head_coord_vertical;
                       end
                       
                3'b011: begin 
                            head_coord_horizontal <= head_coord_horizontal + 10; // Dreapta
                            head_coord_vertical <= head_coord_vertical;
                       end
                       
                3'b100: begin 
                            head_coord_horizontal <= head_coord_horizontal; // Stand
                            head_coord_vertical <= head_coord_vertical;
                       end            
                       
                default: begin 
                              head_coord_horizontal <= head_coord_horizontal; 
                              head_coord_vertical <= head_coord_vertical; 
                          end // Men?ine coordonatele constante dacã nu este selectatã nicio direc?ie
            endcase
        
        end        

    
end


always@(posedge clk) begin
    if(reset_to_start == 1)
        begin
            state <= START;
            reset_to_start <= 0;
        end
    else
        state <= state_next;
end
            
always@(posedge clk) 
begin
                if(ps2_data_out == 8'h1C) 
                    led_test <= 1;
                else 
                    led_test <= 0; 
end                    

//circuit combinational pentru calculul starii urmatoare
always@(posedge clk) begin
    state_next = state;
    case(state)
        START:
           
            begin   
                    
                    reset_digit <= 1; 
                    stand <= 1; 
                    //direction_left <= 1; 
                    //head_coord_horizontal <= 470; 
                    //head_coord_vertical   <= 300; 
                    //isactive_lfsr_reset_sanki <= 0; //Pentru testare
                    //count_increment_score_sanki <= 0; //Pentru testare
                    
                    if (direction_left_forced != 0) 
                        begin 
                                state_next <= GAME; 
                                stand <= 0; 
                                reset_digit <= 0; 
                        end        
                    else
                        begin
                                state_next <= START; 
                        end    
            end
            
        GAME:
        
            begin   
                    reset_lfsr_sanki <= 1; 
                    count_increment_score_sanki <= 0; 
                    isactive_lfsr_reset_sanki <= 0;
                    //Border check 
                    if (head_coord_horizontal == 210 || head_coord_horizontal == 710 || head_coord_vertical == 200 || head_coord_vertical == 470) 
                        begin
                            
                            reset_lfsr_sanki <= 0; 
                            state_next <= LOSE;
                            direction <= 3'b100; 
                            stand <= 1; 
                            
                        end
                    
                    else if (isactive_digit9) 
                            begin
                                
                                reset_lfsr_sanki <= 0; 
                                state_next <= WIN;
                                direction <= 3'b100;
                                stand <= 1;
                               
                             end
                             
                         else if(head_coord_horizontal == lfsr_horizontal_coord && head_coord_vertical == lfsr_vertical_coord)
                            
                             begin
                                
                                state_next <= GAME;
                                count_increment_score_sanki <= 1;
                                isactive_lfsr_reset_sanki <= 1; 
                                
                             end
                             
                                else 
                                    begin
                                        state_next <= GAME; 
                                        count_increment_score_sanki <= 0;
                                        isactive_lfsr_reset_sanki <= 0;            
                                    end
                                    
            end
            
        WIN:
            begin
                    if (reset_to_start) 
                        begin 
                            state_next <= START; 
                            isactive_youwin <= 0;
                            reset_digit <= 1; 
                        end 
                    else 
                        begin
                            stand <= 1; 
                            isactive_youwin <= 1;
                        end
            
            end  
        LOSE:
            begin
                    if (reset_to_start) 
                        begin 
                            state_next <= START; 
                            isactive_youlose <= 0;
                            reset_digit <= 1; 
                        end 
                    else 
                        begin
                            stand <= 1; 
                            isactive_youlose <= 1;
                        end    
            end
                     
        default: state_next = START;
	
    endcase
end


//circuit combinational pentru calculul iesirilor
assign head_modified_position_horizontal  = head_coord_horizontal;
assign head_modified_position_vertical = head_coord_vertical;

assign count_increment_score = (count_increment_score_sanki); 
assign isactive_lfsr = (isactive_lfsr_reset_sanki); 

assign reset_digit_sanki = (reset_digit);            
//assign led_test = led_test_2;      

endmodule