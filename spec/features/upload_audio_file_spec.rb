require 'rails_helper'

def support_file(filename)
  Rails.root.join("spec/support/#{filename}")
end

RSpec.feature 'upload an audio file' do
  context 'when loading the home page' do
    it 'renders without error' do
      visit '/'
      expect(page).to have_content('Turn your recorded meetings')
    end
  end

  context 'saves a file to the database' do
    it 'creates an audio record and uploads the file to storage' do
      visit '/'
      attach_file 'audio_file[audio]', support_file('test-file.wav')
      expect{
        click_button "Start Transcription"
      }.to change(AudioFile, :count).by(1)
    end
  end
end
