`timescale 1ns / 1ps

/*  Fa instante de module pentru desen doar cu pixeli care se afiseaza pe ecran
     Adica: 
        Primul pixel din coltul stanga sus de pe ecran va fi cu coord: Horizontal: 144 Vertical: 35
        Ultimul pixel din coltul dreapta sus va avea coord: Horizontal: 783 Vertical: 35
        Primul pixel din coltul stanga jos va avea coord: Horizontal: 144 Vertical: 514
        Ultimul pixel din coltul dreapta jos va avea coord: Horizontal: 783 Vertical: 514 */ 

module Menu_2
    
    (
        input clk,
        
        output [18:0] address_write,
        //output [11:0] data_write
        output  [3:0] red, 
        output  [3:0] green,
        output  [3:0] blue
     
    );
    
    wire clk_25Mhz;
    wire enable_v_counter; 
    wire [15:0] h_count_value; 
    wire [15:0] v_count_value; 
    
    //reg [3:0] red;
    //reg [3:0] green; 
    //reg [3:0] blue; 
    
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
    
    
    reg [15:0] horizontal_start_limit [1:0] = '{0, 150}; 
    reg [15:0] vertical_start_limit [1:0] = '{0, 150};
    reg [15:0] horizontal_end_limit [1:0] = '{500, 300};
    reg [15:0] vertical_end_limit [1:0] = '{500, 300};
    reg [2:0] color [1:0]  = '{4, 1};
    
    parameter number_of_fsm = 2;
    
    genvar i; 
    
    generate
        for(i = 0; i < number_of_fsm; i = i + 1)
        begin: fsm_inst_gen
               
    
                Draw_FSM_Rectangle_2 
                
                (
                    .horizontal_start_limit(horizontal_start_limit[i]),
                    .vertical_start_limit(vertical_start_limit[i]),
                    .horizontal_end_limit(horizontal_end_limit[i]),
                    .vertical_end_limit(vertical_end_limit[i]), 
                    .color(color[i]), 
            
                    .clk(clk_25Mhz),
                    .horizontal_actual_position(h_count_value),
                    .vertical_actual_position(v_count_value),
                    
                    //.addr(address_write), 
                    .r(red[i]), 
                    .g(green[i]), 
                    .b(blue[i])
            
                );
                
        end        
    endgenerate            
    
    assign red = combine_colors(red);
    assign green = combine_colors(green); 
    assign blue = combine_colors(blue);
 
    
    function [3:0] combine_colors[number_of_fsm];
        input [3:0] colors[number_of_fsm]; 
        reg [3:0] combined_color; 
        integer j; 
    begin
        
        combined_color = colors[0];  
        for (j = 1; j < number_of_fsm; j = j + 1) 
            begin
                combined_color = (combined_color & ~colors[j]) | colors[j];
            end
    combine_colors = combined_color;
    end
endfunction
    
    
    
    //assign addr_write = (v_count_value * 800) + h_count_value;
    //assign data_write = {red, green, blue}; 
    
    
    
    
endmodule
