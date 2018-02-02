class AddConfidenceToAudioFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :audio_files, :confidence, :decimal, precision: 15, scale: 13
  end
end
