`timescale 1ns / 1ps

module top_module
    (
        input wire clk, 
        input wire reset, 
        input wire ps2d,
        input wire ps2c, 
        input rx_en, 
        input reg_en,
        input isactive_digit_forced,
        
        input stand_for_pong, 
        //input reset_button_for_pong,
        
        //input sel_f1, 
        //input sel_f2, 
        //input sel_f3,
        //input reset_button_for_snake,
        //input reset_forced_lfsr,     
        input direction_left_forced,
        
        output wire hsynq, 
        output wire vsynq, 
        
        output wire  [3:0] r, 
        output wire  [3:0] g, 
        output wire  [3:0] b,
        
        output wire led,
        output wire led_test,
        output wire ps2_data_out, 
        output wire [7:0] dac_out

    
    );
    
    wire w_out_reset_lfsr_snake; 
    wire w_out_reset_to_start_snake; 
    wire w_out_reset_to_start_pong;
    wire w_out_reset_to_checkpoint_pong;
    wire [3:0] w_paddle_movement; 
    wire w_jump_dino_button; 
    wire w_reset_dino_button; 
    
    wire w_b;
    wire[7:0] w_ps2;
    
    wire [18:0] addr_write_wire_from_menu;
    wire [18:0] wire_addr_read_count_to_ram;
    wire [11:0] data_write_from_menu;
    wire [11:0] data_from_ram_to_VGA_driver; 
    
    wire  w_hsynq_dino, w_vsynq_dino; 
    wire [3:0] w_red_dino, w_green_dino, w_blue_dino;
    wire w_out_sel_dino; 
    
    wire w_hsynq, w_vsynq;
    wire [11:0] w_data_out; 
    
    wire w_audio_snake, w_audio_pong; 
    
    assign ps2_data_out = (w_ps2 == 8'h1C) ? 1 : 0; 
    
    top_module_ps2_keyboard m0
    (
    
    .clk(clk), 
    .reset(reset), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .rx_en(rx_en), 
    .reg_en(reg_en),
    
    .data_out(w_ps2),
    .out_reset_lfsr_snake(w_out_reset_lfsr_snake),
    .out_reset_to_start_snake(w_out_reset_to_start_snake),
    .out_reset_to_start_pong(w_out_reset_to_start_pong),
    .out_reset_to_checkpoint_pong(w_out_reset_to_checkpoint_pong),
    .paddle_movement(w_paddle_movement),
    .jump_dino_button(w_jump_dino_button),
    .reset_dino_button(w_reset_dino_button),
    .dout_b(w_b)
    ); 
  
    Menu m3
    
    (
        .clk(clk),
        //.sel_f1(sel_f1), 
        //.sel_f2(sel_f2), 
        //.sel_f3(sel_f3),
        //.reset_menu(w_g),
        .ps2_data_out(w_ps2),
        .reset_button_for_snake(w_out_reset_to_start_snake),
        .reset_forced_lfsr(w_out_reset_lfsr_snake),     
        .direction_left_forced(direction_left_forced),
        .isactive_digit_forced(isactive_digit_forced),
        .paddle_movement(w_paddle_movement), 
        
        .reset_button_for_pong(w_out_reset_to_start_pong), 
        .reset_to_checkpoint_pong(w_out_reset_to_checkpoint_pong),
        .stand_for_pong(stand_for_pong),
        
        .jump_dino_button(w_jump_dino_button),
        .reset_dino_button(w_reset_dino_button),
        
        .address_write(addr_write_wire_from_menu),
        .data_write(data_write_from_menu),
        .led_test(led_test), 
        .audio_snake(w_audio_snake),
        .audio_pong(w_audio_pong) 

    );
 
    
    addr_read_counter m69
    (
        .addr_write(addr_write_wire_from_menu), 
        .constant(8000),
        .addr_read(wire_addr_read_count_to_ram)
    );
    
    
    RAM_Frame_Actual m5
    (
       .clk(clk),  
       .addr_write(addr_write_wire_from_menu),
       .addr_read(wire_addr_read_count_to_ram),
       .ram_enable(1),
       .data_write(data_write_from_menu),
       .data_read(data_from_ram_to_VGA_driver)
           

    );
    
    top_module_vga_screen_v2 m2 
    (
        .clk(clk), 
        .address_in(wire_addr_read_count_to_ram),
        .data_in(data_from_ram_to_VGA_driver),
        
        .hsynq(hsynq), 
        .vsynq(vsynq), 
        .data_out({r,g,b})
    );
    
    audio_player_v2 audio_module (
    .clk(clk),             
    .pong_button(w_audio_pong),
    .snake_button(w_audio_snake),
    .dac_out(dac_out)   
);

endmodule