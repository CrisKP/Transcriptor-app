require 'rails_helper'

def support_file(filename)
  Rails.root.join("spec/support/#{filename}")
end

RSpec.feature 'see an indication that the submission has been made' do
  before do
    visit '/'
    attach_file 'audio_file[audio]', support_file('test-file.wav')
    fill_in('audio_file[title]', with: 'test title')
    click_button "Start Transcription"
  end

  context 'when a valid submission has been made' do
    it 'displays the success message' do
      expect(page).to have_content 'File "test title" has been received and queued for transcription.'
    end
  end
end
