`timescale 1ns / 1ps

module video_1
    (
        input wire clk, 
        input wire reset, 
        input wire ps2d,
        input wire ps2c, 
        input rx_en, 
        input reg_en,
        
        output wire led_test,
        output wire ps2_data_out

    );
    
    wire w_b;
    wire[7:0] w_ps2;
    
    top_module_ps2_keyboard m0
    (
    
    .clk(clk), 
    .reset(reset), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .rx_en(rx_en), 
    .reg_en(reg_en),
    
    .data_out(w_ps2),
    .out_reset_lfsr_snake(),
    .out_reset_to_start_snake(),
    .out_reset_to_start_pong(),
    .out_reset_to_checkpoint_pong(),
    .paddle_movement(),
    .jump_dino_button(),
    .reset_dino_button(),
    .dout_b(led_test)
    );
    
    assign ps2_data_out = (w_ps2 == 8'h1C) ? 1 : 0; 
    assign led_test = w_b; 
    
endmodule
