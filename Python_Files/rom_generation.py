import wave
import numpy as np

# Încărcare fișier WAV
with wave.open(r"C:\Users\stefa\Desktop\Licenta\Audio\WAV\sound5_8bit.wav", "rb") as wav_file:
    params = wav_file.getparams()
    frames = wav_file.readframes(params.nframes)
    samples = np.frombuffer(frames, dtype=np.uint8)  # 8 biți

# Generarea fișierului ROM Verilog
with open(r"C:\Users\stefa\Desktop\Licenta\Audio\audio_rom5.v", "w") as rom_file:
    rom_file.write("module audio_rom (\n")
    rom_file.write("    input wire [19:0] addr,\n")  # N Adrese
    rom_file.write("    output reg [7:0] data\n")
    rom_file.write(");\n")
    rom_file.write("    always @* begin\n")
    rom_file.write("        case (addr)\n")

    for i, sample in enumerate(samples):
        rom_file.write(f"            20'd{i}: data = 8'h{sample:02X};\n")

    rom_file.write("            default: data = 8'h00;\n")
    rom_file.write("        endcase\n")
    rom_file.write("    end\n")
    rom_file.write("endmodule\n")
