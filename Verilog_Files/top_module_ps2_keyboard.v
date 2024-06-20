`timescale 1ns / 1ps

module top_module_ps2_keyboard
    (
    
    input wire clk, reset , 
    input wire ps2d, ps2c, rx_en, reg_en,
    
    output wire [7:0] data_out,
    output wire out_reset_lfsr_snake,
    output wire out_reset_to_start_snake,
    output wire out_reset_to_start_pong,
    output wire out_reset_to_checkpoint_pong,
    output wire [3:0] paddle_movement,
    output wire jump_dino_button, 
    output wire reset_dino_button,
    
    
    output wire dout_b

    );
    
    wire paddle_1_move_up, paddle_1_move_down, paddle_2_move_up, paddle_2_move_down;  
    
    wire [7:0] w1, w2, w3, w5;
    wire w4; 
    wire rx_done_tick;
 
      
        
        ps2_rx m0
	(
	.clk(clk), .reset(reset), 
	.ps2d(ps2d), .ps2c(ps2c), .rx_en(rx_en),  
	.dout(w1),
	.rx_done_tick(rx_done_tick)	
	); 

    
    shift_reg_8bit_3loc m1
    (
    .clock(clk),
    .reset(reset),
    .enable((reg_en && rx_done_tick)),
    .data_in(w1),
    .data_out3(w5),
    //.data_out2(w6),
    .verify(w4)
    );

	
	verification_module m2
    
    (
        .verify(w4),
        .in(w5),
        //.in1(w6), 
        .out_reset_lfsr_snake(out_reset_lfsr_snake),
        .out_reset_to_start_snake(out_reset_to_start_snake),
        .out_reset_to_start_pong(out_reset_to_start_pong),
        .out_reset_to_checkpoint_pong(out_reset_to_checkpoint_pong),
        .paddle_1_move_up(paddle_1_move_up),
        .paddle_1_move_down(paddle_1_move_down),
        .paddle_2_move_up(paddle_2_move_up),
        .paddle_2_move_down(paddle_2_move_down),
        .jump_dino_button(jump_dino_button), 
        .reset_dino_button(reset_dino_button), 
        .out_b(dout_b), 
        .data_out(data_out)
    );
    
    assign paddle_movement = {paddle_1_move_up ,paddle_1_move_down, paddle_2_move_up, paddle_2_move_down}; 
    
endmodule
