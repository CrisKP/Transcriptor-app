class AddTranscriptionStartedAtToAudioFile < ActiveRecord::Migration[5.1]
  def change
    add_column :audio_files, :transcription_started_at, :datetime
  end
end
