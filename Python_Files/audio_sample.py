import os
from moviepy.editor import AudioFileClip

def convert_mp3_to_wav_8bit(mp3_path, wav_path):
    # Load the MP3 file
    audio = AudioFileClip(mp3_path)

    # Set the sample rate to 11.025 Hz and bit depth to 8 bits
    audio = audio.set_fps(11025)

    # Export as WAV
    audio.write_audiofile(wav_path, bitrate="8k", codec="pcm_u8")

# Specify the directory containing the MP3 files
mp3_directory = r"C:\Users\stefa\Desktop\Licenta\Audio\MP3"

# Specify the directory to save the converted WAV files
wav_directory = r"C:\Users\stefa\Desktop\Licenta\Audio\WAV"

# Create the WAV directory if it doesn't exist
os.makedirs(wav_directory, exist_ok=True)

# Iterate over all MP3 files in the directory
for filename in os.listdir(mp3_directory):
    if filename.endswith(".mp3"):
        mp3_path = os.path.join(mp3_directory, filename)
        wav_filename = os.path.splitext(filename)[0] + "_8bit.wav"
        wav_path = os.path.join(wav_directory, wav_filename)

        # Convert MP3 to 8-bit WAV
        convert_mp3_to_wav_8bit(mp3_path, wav_path)
        print(f"Converted {filename} to {wav_filename}")