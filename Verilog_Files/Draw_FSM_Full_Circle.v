`timescale 1ns / 1ps


module Draw_FSM_Full_Circle # 
    
    (
        parameter x_center = 0,
        parameter y_center = 0,
        parameter radius = 10,
        parameter color = 0   
        
    )
    
    (
        input clk,
        input [15:0] horizontal_actual_position,
        input [15:0] vertical_actual_position,
        
        output [18:0] addr, 
        output reg [11:0] data_out

    );
    
        reg [11:0] data; 
        reg [31:0] x, y, d; 
    
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
            
            x <= horizontal_actual_position - x_center;
            y <= vertical_actual_position - y_center;
            d <= x*x + y*y - radius*radius;
            
            if (d <= 0 && d >= -2*radius)
                 data_out <= data;
            else
                 data_out <= 12'b000000000000; 
        
        end      
          
   
   // ADDRESS CALCULATION     
    
      assign addr = (vertical_actual_position * 800) + horizontal_actual_position;     
    
    
endmodule