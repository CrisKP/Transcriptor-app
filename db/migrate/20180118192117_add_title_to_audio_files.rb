class AddTitleToAudioFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :audio_files, :title, :string
  end
end
