`timescale 1ns / 1ps

module Win_Logic_Pong
    
    (
        
        input player_1_isactive_5, 
        input player_2_isactive_5, 
        
        output player_1_win_isactive, 
        output player_2_win_isactive
      
    );

        assign player_1_win_isactive = (player_1_isactive_5) ? 1 : 0; 
        assign player_2_win_isactive = (player_2_isactive_5) ? 1 : 0; 
    
endmodule
