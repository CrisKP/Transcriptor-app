class CreateAudioFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :audio_files do |t|

      t.timestamps
    end

    add_attachment :audio_files, :audio
  end
end
