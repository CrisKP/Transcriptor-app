class AddTranscriptionToAudioFile < ActiveRecord::Migration[5.1]
  def change
    add_column :audio_files, :transcription, :binary, limit: 10.megabytes
    add_column :audio_files, :transcribed_at, :datetime, default: nil
  end
end
