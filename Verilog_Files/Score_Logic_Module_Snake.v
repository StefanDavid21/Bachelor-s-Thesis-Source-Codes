`timescale 1ns / 1ps

module Score_Logic_Module_Snake
    
    (
        input clk, 
        input is_active_in, 
        input rst, 
        
        output isactive_0,
        output isactive_1,
        output isactive_2,
        output isactive_3,
        output isactive_4,
        output isactive_5,
        output isactive_6,
        output isactive_7,
        output isactive_8,
        output isactive_9

    );
    
    reg [3:0] value;
    reg [3:0] count; 
    reg btn_prev_state;
    
    always@(posedge clk)
        begin
            if(rst == 1) 
                begin
                    count <= 0;
                    btn_prev_state <= 0; 
                end
            else
                begin 
                
                    if(count == 10) 
                    
                         count <= 0; 
                    else 
                        if(is_active_in == 1 && btn_prev_state == 0)
                            begin 
                                count <= count + 1;
                                btn_prev_state <= 1; 
                            end
                        else
                            begin
                                if(is_active_in == 0) 
                                    begin
                                        btn_prev_state <= 0; 
                                    end
                            end                
                end
        end
    
    always@(posedge clk) 
        begin 
            case(count)           
                0: value = 4'd0; // 0 
                1: value = 4'd1; // 1
                2: value = 4'd2; // 2
                3: value = 4'd3; // 3
                4: value = 4'd4; // 4
                5: value = 4'd5; // 5 
                6: value = 4'd6; // 6 
                7: value = 4'd7; // 7 
                8: value = 4'd8; // 8
                9: value = 4'd9; // 9   
                default : value = 4'd0; //default value 0          
            endcase
        end
        
    assign isactive_0 = (value == 0) ? 1 : 0 ;
    assign isactive_1 = (value == 1) ? 1 : 0 ;
    assign isactive_2 = (value == 2) ? 1 : 0 ;
    assign isactive_3 = (value == 3) ? 1 : 0 ;    
    assign isactive_4 = (value == 4) ? 1 : 0 ;
    assign isactive_5 = (value == 5) ? 1 : 0 ;
    assign isactive_6 = (value == 6) ? 1 : 0 ;
    assign isactive_7 = (value == 7) ? 1 : 0 ; 
    assign isactive_8 = (value == 8) ? 1 : 0 ;
    assign isactive_9 = (value == 9) ? 1 : 0 ;
        
endmodule
