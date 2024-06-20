`timescale 1ns / 1ps

module Dino_Top(
    input clk,button,debug,
    input isactive,
    output hsync,vsync,
    output [3:0] red,green,blue, 
    output [11:0] data_write, 
    output [18:0] address_write 
    );
    
    //Initializing internal wires
    wire [10:0] scrolladdr;
    wire [9:0] vaddress,haddress;
    wire [6:0] jaddr;
    wire [4:0] random1;
    wire [3:0] color;
    wire runner,reset,score;
    
    wire clk_25Mhz; 
    wire enable_v_counter; 
    wire [15:0] h_count_value; 
    wire [15:0] v_count_value;
    
    //Initializing internal regs for sprites
    reg [22:0] run1 [46:0];
    reg [22:0] run2 [46:0];
    reg [22:0] death [46:0];
    reg [255:0] floor [5:0];
    reg [26:0] cactus1 [46:0];
    reg [26:0] cactus2 [46:0];
    reg [12:0] cactus3 [48:0];
    reg [2:0] select,type;
    reg collide;
    
    //Initializing pixel layers data reg
    reg [4:0] layer;
    
    //Assigning outputs
    assign red = (isactive) ? color : 0;
    assign green = (isactive) ? color : 0;
    assign blue = (isactive) ? color : 0;
    assign color = {4{layer[0]|layer[1]|layer[2]|layer[3]|layer[4]|score}};
    assign reset = collide&button;
    assign data_write = {red, green, blue}; 
    assign address_write = (v_count_value * 800) + h_count_value;
    
    //Initializing sprite memory from files
    initial begin //TODO: Fix this idiot
    $readmemb("dino.mem", run1);
    $readmemb("dino2work.mem", run2);
    $readmemb("death.mem",death);
    $readmemb("floor.mem", floor);
    $readmemb("cactus.mem", cactus1);
    $readmemb("cactus2.mem", cactus2);
    $readmemb("cactus3.mem", cactus3);
    collide <= 1;
    select <= 0;
    type <= 0;
    end
    
    //Initializing all submodules
    jumping jumping_inst(
    .clk(clk),
    .button(button),
    .jumpaddr(jaddr),
    .halt(collide),
    .reset(reset)
    );
    dinosprite dinosprite_inst(
    .clk(clk),
    .sprite(runner)
    );
    scroll scroll_inst(
    .clk(clk),
    .pos(scrolladdr[10:0]),
    .halt(collide),
    .reset(reset)
    );
    top_module_vga_screen vga
    (
       .clk(clk), 

        .hsynq(hsync), 
        .vsynq(vsync), 
        .haddress(haddress), 
        .vaddress(vaddress)
        
    );
    rng rng_inst(
    .clk(clk),
    .button(button),
    .random1(random1)
    );
    score score_inst(
    .clk(clk),
    .halt(collide),
    .reset(reset),
    .vaddress(vaddress),
    .haddress(haddress),
    .pixel(score)
    );
    
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
    
    //Main block
    always@(posedge clk_25Mhz)begin
        collide <= (layer[0]&(layer[1]|layer[3]|layer[4]))|(collide&~button); //TODO:Test outside of always block
        if(debug == 1)begin //Collision debug code TODO:remove in final
            collide <= 0;
        end
        layer <= 5'b0; //Set all pixel layers to 0
        if(v_count_value < 480 && h_count_value < 640)begin //Check if video address is within scan area
            if(h_count_value > 100 && h_count_value < 123 && (v_count_value + jaddr) > 200 && (v_count_value + jaddr) < 247)begin //Check x and y position for printing dinosaur sprite
                //Alternate between running types or death character
                if(collide)begin
                    layer[0] <= death[v_count_value-200+jaddr][h_count_value-100];
                end
                else begin
                    if(runner)begin
                        layer[0] <= run1[v_count_value-200+jaddr][h_count_value-100];
                    end
                    else begin
                        layer[0] <= run2[v_count_value-200+jaddr][h_count_value-100];
                    end
                end
            end
            if(v_count_value > 244 && v_count_value < 251) begin //Check the y address for printing floor/ground
                layer[2] <= floor[v_count_value-245][(h_count_value)+scrolladdr[7:0]];
            end
            if (v_count_value > 203 && v_count_value < 250)begin
                if(select[0])begin
                    if(type[0])begin
                        if((h_count_value + scrolladdr[9:0]) > 640 && (h_count_value + scrolladdr[9:0]) < 667)begin //Cactus test
                            layer[1] <= cactus1[v_count_value-203][h_count_value-640+scrolladdr[9:0]];
                        end
                    end
                    else begin
                        if((h_count_value + scrolladdr[9:0]) > 640 && (h_count_value + scrolladdr[9:0]) < 667)begin //Cactus test
                            layer[1] <= cactus2[v_count_value-203][h_count_value-640+scrolladdr[9:0]];
                        end
                    end
                end
                if(select[1])begin
                    if(type[1])begin
                        if((h_count_value + scrolladdr[9:0]-250) > 640 && (h_count_value + scrolladdr[9:0]-250) < 667)begin //Cactus test
                            layer[3] <= cactus2[v_count_value-203][h_count_value-640+scrolladdr[9:0]-250];
                        end
                    end
                end
                if(select[2])begin
                    if(type[2])begin
                        if((h_count_value + scrolladdr[10:0]-450) > 640 && (h_count_value + scrolladdr[10:0]-450) < 667)begin //Cactus test
                            layer[4] <= cactus1[v_count_value-203][h_count_value-640+scrolladdr[10:0]-450];
                        end
                    end
                    else begin
                        if((h_count_value + scrolladdr[10:0]-450) > 640 && (h_count_value + scrolladdr[10:0]-450) < 667)begin //Cactus test
                            layer[4] <= cactus3[v_count_value-203][h_count_value-640+scrolladdr[10:0]-450];
                        end
                    end
                end
            end
            if(scrolladdr[9:0]==0)begin
                select[0] <= 1;
            end
            if(scrolladdr[9:0]==250)begin
                select[1] <= 1;
            end
            if(scrolladdr[9:0]==450)begin
                select[2] <= 1;
            end
            if(scrolladdr[9:0] > 667)begin
                select[0] <= 0;
            end
            if(scrolladdr[9:0] > 917)begin
                select[1] <= 0;
            end
            if(scrolladdr[10:0] > 1117)begin
                select[2] <= 0;
            end
        end //End of valid scan area
    end //End of main block
    
    always@(posedge select[0])begin
        type[0] <= random1[2];
    end
    always@(posedge select[1])begin
        type[1] <= random1[3];
    end
    always@(posedge select[2])begin
        type[2] <= random1[4];
    end
    
endmodule