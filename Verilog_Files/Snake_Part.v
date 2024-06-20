`timescale 1ns / 1ps

/* YOU NEED TO SELECT AN OFFSET TO CHOOSE THE RIGHT SYMBOL
    
    Offset Value Legend: 
    
    1 -> Snake Part (1) 
       
 */

module Snake_Part #
    (     
        
        parameter color = 4,
        parameter offset = 1, 
        parameter number_of_fsm = 1, 
        parameter index = 1 //S-ar putea sa fie redundan, pentru ca pe mine la fiecare part ma intereseaza doar coordonatele si daca e active 
        // Indexul s-ar putea sa il dau din game logic si sa fie ceva intern, sa nu aibe legatura cu top-ul 
         
    )
    
    (   
        
        input [10:0] horizontal_start_limit,
        input [10:0] vertical_start_limit,
        
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


// Alphabet

    generate
    
    case(offset)
     
     1: // snake part
     begin
               
            Draw_FSM_Rectangle_Unparameterized Snake_Part
    
        
        (
            .clk(clk_25Mhz),
            
            .isactive(0), //De tinut minte daca nu merge sa se schimbe din 0 in 1 nu mai sunt sigur cum e
            
            .horizontal_start_limit(horizontal_start_limit), 
            .vertical_start_limit(vertical_start_limit),
            .horizontal_end_limit(horizontal_start_limit + 10), 
            .vertical_end_limit(vertical_start_limit + 10), 
            .color(4),
            
            .horizontal_actual_position(h_count_value),
            .vertical_actual_position(v_count_value),
            
            .addr(address_write_wire[0]), 
            .data_out(data_write_wire[0])
    
        );
                 
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
