`timescale 1ns / 1ps


module Draw_FSM_Rectangle_2  

    (
        input clk,
        input [15:0] horizontal_actual_position,
        input [15:0] vertical_actual_position,
        input [15:0] horizontal_start_limit,
        input [15:0] vertical_start_limit,
        input [15:0] horizontal_end_limit,
        input [15:0] vertical_end_limit, 
        input [2:0]  color, 
        
        //output [18:0] addr, 
        //output reg [11:0] data_out
        output reg [3:0] r, 
        output reg [3:0] g,
        output reg [3:0] b

    );
    
        reg [11:0] data; 
    
    // CASE FOR COLOR CHOICE
    
    always @(posedge clk)
    begin
 
                case(color)
                
                    0: data = 12'b000000000000;  // black
                    1: data = 12'b111100000000;  // red 
                    2: data = 12'b000011110000;  // green
                    3: data = 12'b000000001111;  // blue
                    4: data = 12'b111111111111;  // white
                            
                endcase    
        
    end
 /*  Fa instante de module pentru desen doar cu pixeli care se afiseaza pe ecran
     Adica: 
        Primul pixel din coltul stanga sus de pe ecran va fi cu coord: Horizontal: 144 Vertical: 35
        Ultimul pixel din coltul dreapta sus va avea coord: Horizontal: 783 Vertical: 35
        Primul pixel din coltul stanga jos va avea coord: Horizontal: 144 Vertical: 514
        Ultimul pixel din coltul dreapta jos va avea coord: Horizontal: 783 Vertical: 514 */
    
   
   // CONDITION FOR DRAW
   
   always@(posedge clk)
        
        begin
            if(horizontal_actual_position >= horizontal_start_limit && 
               horizontal_actual_position <= horizontal_end_limit && 
               vertical_actual_position >= vertical_start_limit && 
               vertical_actual_position <= vertical_end_limit) 
               begin 
                    //data_out <= data; 
                    r <= data[11:8]; 
                    g <= data[7:4]; 
                    b <= data[3:0];
               end
            
            else 
                begin
                    //data_out <= 12'b000000000000; 
                    r <= 4'b0000;
                    g <= 4'b0000;
                    b <= 4'b0000;
                end    
        
        end      
          
   
   // ADDRESS CALCULATION     
    
      //assign addr = (vertical_actual_position * 800) + horizontal_actual_position;     
    
    
endmodule