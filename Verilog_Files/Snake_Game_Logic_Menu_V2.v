`timescale 1ns / 1ps
module Snake_Game_Logic_Menu_V2
    
    (
    
        input clk,
        input [7:0] ps2_data_out,
        
        input reset_to_start,
        //input stand,
        input isactive_9,
        
        input [15:0] horizontal_lfsr, 
        input [15:0] vertical_lfsr,
        
        input you_lose_from_collision,
        
        output isactive_digit, 
        output reset_digit, 
        
        output enable_shift_register,
        output isactive_lfsr, 
        output reset_lfsr,
        
        output isactive_you_lose, 
        output isactive_you_win, 
        
        output [10:0] head_modified_position_horizontal,
        output [10:0] head_modified_position_vertical, 
        output wire_stand

    );
reg stand;     
reg [10:0] head_coord_horizontal, head_coord_horizontal_next, head_coord_vertical, head_coord_vertical_next;    
reg [2:0] direction; 
reg reg_isactive_lfsr, reg_isactive_digit, reg_reset_lfsr, reg_reset_isactive_digit;
//reg reset_to_start;
reg pulse_signal, prev_pulse_signal; 
reg pulse_youwin, prev_pulse_youwin; 
reg pulse_youlose, prev_pulse_youlose;
reg isactive_youlose_reg;

always@(posedge clk) begin
    
    case(ps2_data_out)
    
        8'h43: direction <= 3'b000; // I pentru sus
        8'h42: direction <= 3'b001; // K pentru jos
        8'h3B: direction <= 3'b010; // J pentru stanga
        8'h4B: direction <= 3'b011; // L pentru dreapta

        default: direction <= direction; 
    endcase
end   
      

always@(posedge clk) 
begin 
    
    if (reset_to_start) 
        begin
            head_coord_horizontal <= 470;
            head_coord_vertical <= 300;
            
            reg_reset_lfsr <= 1; 
            reg_reset_isactive_digit <= 1; 
              
            reg_isactive_lfsr <= 0; 
            reg_isactive_digit <= 0; 
             
        end
    
    else if(!stand)
        begin
                
                reg_reset_lfsr <= 0; 
                reg_reset_isactive_digit <= 0; 
                
                case(direction)
                    3'b000: head_coord_vertical <= head_coord_vertical - 10; // Sus
                    3'b001: head_coord_vertical <= head_coord_vertical + 10; // Jos
                    3'b010: head_coord_horizontal <= head_coord_horizontal - 10; // Stanga
                    3'b011: head_coord_horizontal <= head_coord_horizontal + 10; // Dreapta
                    default:
                    begin
                        head_coord_horizontal <= head_coord_horizontal;
                        head_coord_vertical <= head_coord_vertical;
                    end
                endcase
        end
    else
        begin   
                  reg_reset_lfsr <= 0; 
                  reg_reset_isactive_digit <= 0; 
                
                  head_coord_horizontal <= head_coord_horizontal;
                  head_coord_vertical <= head_coord_vertical;                          
        end    
        
end  

always@(posedge clk)
    begin
    
        if(reset_to_start)
            begin   
                pulse_youwin <= 0; 
            end
       else
            begin     
        
                if(isactive_9) 
                    begin 
                            pulse_youwin <= 1; 
                    end
                 
                 else
                    begin
                            pulse_youwin <= 0; 
                    end   
                    
            end
                  
    end

always@(posedge clk)
begin
    if(reset_to_start)
        begin
            pulse_youlose <= 0;
            isactive_youlose_reg <= 0;
        end
    else
        begin
            if(head_coord_horizontal == 210 || head_coord_horizontal == 710 || head_coord_vertical == 200 || head_coord_vertical == 460 || you_lose_from_collision == 1) 
                begin 
                    pulse_youlose <= 1;
                    isactive_youlose_reg <= 1;
                end
            else if(isactive_youlose_reg == 1)
                begin
                    pulse_youlose <= 1;
                    isactive_youlose_reg <= 1;
                end
            else
                begin
                    pulse_youlose <= 0;
                    isactive_youlose_reg <= 0;
                end   
        end     
end       

always@(posedge clk)
begin
    if(reset_to_start)
        stand <= 0;
    else if(pulse_youlose == 1 || you_lose_from_collision == 1)
        stand <= 1;
    else if(pulse_youwin == 1 && stand == 0)
        stand <= 1;
    else
        stand <= stand;
end
    

always@(posedge clk) 
begin
    if(head_coord_horizontal >= horizontal_lfsr - 5 && head_coord_horizontal <= horizontal_lfsr + 5 && head_coord_vertical >= vertical_lfsr - 5 && head_coord_vertical <= vertical_lfsr + 5)
        begin
            
            pulse_signal <= 1; 
            
        end
    else
        begin
        
            pulse_signal <= 0; 
            
        end    
    
    prev_pulse_signal <= pulse_signal; 
    
end

assign isactive_you_win = pulse_youwin; 
assign isactive_you_lose = isactive_youlose_reg; 
assign wire_stand = stand; 

assign isactive_lfsr = pulse_signal & ~prev_pulse_signal;
assign isactive_digit = pulse_signal & ~prev_pulse_signal;
    
assign head_modified_position_horizontal  = head_coord_horizontal;
assign head_modified_position_vertical = head_coord_vertical;    
//assign isactive_lfsr = reg_isactive_lfsr; 
//assign isactive_digit = reg_isactive_digit; 
assign reset_digit = reg_reset_isactive_digit; 
assign reset_lfsr = reg_reset_lfsr;
assign enable_shift_register = (stand) ? 0 : 1;     
endmodule
