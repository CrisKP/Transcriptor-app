class RenameTranscribedAtToTranscriptionCompletedAt < ActiveRecord::Migration[5.1]
  def change
    rename_column :audio_files, :transcribed_at, :transcription_completed_at
  end
end
