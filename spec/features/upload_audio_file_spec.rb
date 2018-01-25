require 'rails_helper'

def support_file(filename)
  Rails.root.join("spec/support/#{filename}")
end

RSpec.feature 'upload an audio file' do
  before do
    visit '/'
  end

  context 'when loading the home page' do
    it 'renders without error' do
      expect(page).to have_content('Turn your recorded meetings')
    end
  end

  context 'when the file is a valid wav' do
    it 'creates an audio record and saves the file to storage' do
      attach_file 'audio_file[audio]', support_file('test-file.wav')
      expect {
        click_button "Start Transcription"
      }.to change(AudioFile, :count).by(1)
    end
  end

  context 'when the file is NOT a valid wav' do
    it 'will not create an audio record and save the file to storage' do
      attach_file 'audio_file[audio]', support_file('test-file.mp3')
      expect {
        click_button "Start Transcription"
      }.to change(AudioFile, :count).by(0)
    end
  end
end