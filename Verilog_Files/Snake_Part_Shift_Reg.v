`timescale 1ns / 1ps

module Snake_Part_Shift_Reg(
    input wire clock,
    input wire reset,
    input wire enable,
    
    input wire [10:0] horizontal_head_coord,
    input wire [10:0] vertical_head_coord,
    
    input wire isactive_part_0,
    input wire isactive_part_1,
    input wire isactive_part_2,
    input wire isactive_part_3,
    input wire isactive_part_4,
    input wire isactive_part_5,
    input wire isactive_part_6,
    input wire isactive_part_7,
    input wire isactive_part_8,
    input wire isactive_part_9,
    
     
    
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
    
    output wire you_lose_from_collision

);


    reg [10:0] vertical_part_coord [10:0];
    reg [10:0] horizontal_part_coord [10:0];  
    reg isactive_part [9:0]; 
    reg trigger; 
   

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            
            horizontal_part_coord[0] <= 11'b00000000000;
            horizontal_part_coord[1] <= 11'b00000000000;
            horizontal_part_coord[2] <= 11'b00000000000;
            horizontal_part_coord[3] <= 11'b00000000000;
            horizontal_part_coord[4] <= 11'b00000000000;
            horizontal_part_coord[5] <= 11'b00000000000;
            horizontal_part_coord[6] <= 11'b00000000000;
            horizontal_part_coord[7] <= 11'b00000000000;
            horizontal_part_coord[8] <= 11'b00000000000;
            horizontal_part_coord[9] <= 11'b00000000000;
            horizontal_part_coord[10] <= 11'b00000000000;
            
            vertical_part_coord[0] <= 11'b00000000000;
            vertical_part_coord[1] <= 11'b00000000000;
            vertical_part_coord[2] <= 11'b00000000000;
            vertical_part_coord[3] <= 11'b00000000000;
            vertical_part_coord[4] <= 11'b00000000000;
            vertical_part_coord[5] <= 11'b00000000000;
            vertical_part_coord[6] <= 11'b00000000000;
            vertical_part_coord[7] <= 11'b00000000000;
            vertical_part_coord[8] <= 11'b00000000000;
            vertical_part_coord[9] <= 11'b00000000000;
            vertical_part_coord[10] <= 11'b00000000000;
            
            isactive_part[0] <= 10'b0000000000;
            isactive_part[1] <= 10'b0000000000;
            isactive_part[2] <= 10'b0000000000;
            isactive_part[3] <= 10'b0000000000;
            isactive_part[4] <= 10'b0000000000;
            isactive_part[5] <= 10'b0000000000;
            isactive_part[6] <= 10'b0000000000;
            isactive_part[7] <= 10'b0000000000;
            isactive_part[8] <= 10'b0000000000;      
            isactive_part[9] <= 10'b0000000000;
            
        end else if (enable) begin
            
            horizontal_part_coord[0] <= horizontal_head_coord;
            horizontal_part_coord[1] <= horizontal_part_coord[0];
            horizontal_part_coord[2] <= horizontal_part_coord[1];
            horizontal_part_coord[3] <= horizontal_part_coord[2];
            horizontal_part_coord[4] <= horizontal_part_coord[3];
            horizontal_part_coord[5] <= horizontal_part_coord[4];
            horizontal_part_coord[6] <= horizontal_part_coord[5];
            horizontal_part_coord[7] <= horizontal_part_coord[6];
            horizontal_part_coord[8] <= horizontal_part_coord[7];
            horizontal_part_coord[9] <= horizontal_part_coord[8];
            horizontal_part_coord[10] <= horizontal_part_coord[9];
            
            vertical_part_coord[0] <= vertical_head_coord;
            vertical_part_coord[1] <= vertical_part_coord[0];
            vertical_part_coord[2] <= vertical_part_coord[1];
            vertical_part_coord[3] <= vertical_part_coord[2];
            vertical_part_coord[4] <= vertical_part_coord[3];
            vertical_part_coord[5] <= vertical_part_coord[4];
            vertical_part_coord[6] <= vertical_part_coord[5];
            vertical_part_coord[7] <= vertical_part_coord[6];
            vertical_part_coord[8] <= vertical_part_coord[7];
            vertical_part_coord[9] <= vertical_part_coord[8];
            vertical_part_coord[10] <= vertical_part_coord[9];
            
            isactive_part[0] <= isactive_part_0; 
            isactive_part[1] <= isactive_part_1;
            isactive_part[2] <= isactive_part_2;
            isactive_part[3] <= isactive_part_3;
            isactive_part[4] <= isactive_part_4;
            isactive_part[5] <= isactive_part_5;
            isactive_part[6] <= isactive_part_6;
            isactive_part[7] <= isactive_part_7;
            isactive_part[8] <= isactive_part_8;
            isactive_part[9] <= isactive_part_9;
                
        end
    end
    
    always @(posedge clock)
        begin 
            
            if(horizontal_part_coord[0] == horizontal_part_coord[1] && vertical_part_coord[0] == vertical_part_coord[1] && isactive_part[1] == 1) 
                trigger <= 1; 
            else if (horizontal_part_coord[0] == horizontal_part_coord[2] && vertical_part_coord[0] == vertical_part_coord[2] && isactive_part[2] == 1) 
                trigger <= 1;
            else if (horizontal_part_coord[0] == horizontal_part_coord[3] && vertical_part_coord[0] == vertical_part_coord[3] && isactive_part[3] == 1) 
                trigger <= 1;
            else if (horizontal_part_coord[0] == horizontal_part_coord[4] && vertical_part_coord[0] == vertical_part_coord[4] && isactive_part[4] == 1) 
                trigger <= 1;
            else if (horizontal_part_coord[0] == horizontal_part_coord[5] && vertical_part_coord[0] == vertical_part_coord[5] && isactive_part[5] == 1) 
                trigger <= 1;                
            else if (horizontal_part_coord[0] == horizontal_part_coord[6] && vertical_part_coord[0] == vertical_part_coord[6] && isactive_part[6] == 1) 
                trigger <= 1;
            else if (horizontal_part_coord[0] == horizontal_part_coord[7] && vertical_part_coord[0] == vertical_part_coord[7] && isactive_part[7] == 1) 
                trigger <= 1;
            else if (horizontal_part_coord[0] == horizontal_part_coord[8] && vertical_part_coord[0] == vertical_part_coord[8] && isactive_part[8] == 1) 
                trigger <= 1;
            else if (horizontal_part_coord[0] == horizontal_part_coord[9] && vertical_part_coord[0] == vertical_part_coord[9] && isactive_part[9] == 1) 
                trigger <= 1;       
            else trigger <= 0; 
                              
        end


    assign horizontal_part_0_coord = horizontal_part_coord[0];
    assign horizontal_part_1_coord = horizontal_part_coord[1];
    assign horizontal_part_2_coord = horizontal_part_coord[2];
    assign horizontal_part_3_coord = horizontal_part_coord[3];
    assign horizontal_part_4_coord = horizontal_part_coord[4];
    assign horizontal_part_5_coord = horizontal_part_coord[5];
    assign horizontal_part_6_coord = horizontal_part_coord[6];
    assign horizontal_part_7_coord = horizontal_part_coord[7];
    assign horizontal_part_8_coord = horizontal_part_coord[8];
    assign horizontal_part_9_coord = horizontal_part_coord[9];
    assign horizontal_part_10_coord = horizontal_part_coord[10];
    
    assign vertical_part_0_coord = vertical_part_coord[0];
    assign vertical_part_1_coord = vertical_part_coord[1];
    assign vertical_part_2_coord = vertical_part_coord[2];
    assign vertical_part_3_coord = vertical_part_coord[3];
    assign vertical_part_4_coord = vertical_part_coord[4];
    assign vertical_part_5_coord = vertical_part_coord[5];
    assign vertical_part_6_coord = vertical_part_coord[6];
    assign vertical_part_7_coord = vertical_part_coord[7];
    assign vertical_part_8_coord = vertical_part_coord[8];
    assign vertical_part_9_coord = vertical_part_coord[9];
    assign vertical_part_10_coord = vertical_part_coord[10];
    assign you_lose_from_collision = trigger; 

endmodule





