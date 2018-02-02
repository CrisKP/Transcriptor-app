require 'rails_helper'

def support_file(filename)
  Rails.root.join("spec/support/#{filename}")
end

RSpec.feature 'see an indication that the submission has been made' do
  before do
    visit '/'
    attach_file 'audio_file[audio]', support_file('test-file.wav')
    fill_in('audio_file[title]', with: 'test title')
    fill_in('audio_file[email]', with: 'hello@email.com')
    click_button "Start Transcription"
  end

  context 'when a valid submission has been made' do
    it 'displays the success message' do
      expect(page).to have_content '"test title" transcription sent to hello@email.com!'
    end
  end
end
