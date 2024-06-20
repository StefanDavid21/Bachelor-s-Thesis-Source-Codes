module audio_player_v2 (
    input wire clk,             // Clock
    input wire pong_button,
    input wire snake_button,
    output wire [7:0] dac_out   // Output to DAC
);

    reg [19:0] address_snake;   // Address for snake ROM
    reg [19:0] address_pong;    // Address for pong ROM
    wire [7:0] rom_data_snake;  // Data from ROM for snake
    wire [7:0] rom_data_pong;   // Data from ROM for pong
    reg [19:0] sample_counter;  // Sample counter
    reg playing_snake;          // Flag to indicate if snake sound is playing
    reg playing_pong;           // Flag to indicate if pong sound is playing

    // Instantiate ROMs
    audio_rom_snake snake_sound (
        .addr(address_snake),
        .data(rom_data_snake)
    );

    audio_rom_pong pong_sound (
        .addr(address_pong),
        .data(rom_data_pong)
    );

    // Parameters
    parameter CLK_FREQ = 100000000;    // System clock frequency (e.g., 50 MHz)
    parameter SAMPLE_RATE = 11025;     // Sample rate (11.025 kHz)
    parameter COUNTER_MAX = CLK_FREQ / SAMPLE_RATE;

    // Main logic
    always @(posedge clk) begin
        if (snake_button) begin
            playing_snake <= 1;
            address_snake <= 0;
        end

        if (pong_button) begin
            playing_pong <= 1;
            address_pong <= 0;
        end

        if (playing_snake) begin
            if (sample_counter >= COUNTER_MAX) begin
                sample_counter <= 0;
                address_snake <= address_snake + 1;
                if (address_snake == 19'h7FFFF) begin
                    playing_snake <= 0;
                end
            end else begin
                sample_counter <= sample_counter + 1;
            end
        end

        if (playing_pong) begin
            if (sample_counter >= COUNTER_MAX) begin
                sample_counter <= 0;
                address_pong <= address_pong + 1;
                if (address_pong == 19'h7FFFF) begin
                    playing_pong <= 0;
                end
            end else begin
                sample_counter <= sample_counter + 1;
            end
        end
    end

    assign dac_out = playing_snake ? rom_data_snake : (playing_pong ? rom_data_pong : 8'b0);

endmodule