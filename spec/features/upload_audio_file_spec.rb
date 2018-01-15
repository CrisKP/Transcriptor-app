require 'rails_helper'

def support_file(filename)
  Rails.root.join("spec/support/#{filename}")
end

RSpec.feature 'upload an audio file' do
  context 'when loading the home page' do
    it 'renders without error' do
      visit '/'
      expect(page).to have_content('Transcriptor')
      expect(page).to have_link('Upload a file')
    end
  end

  context 'when the upload a file link is clicked' do
    it 'redirects to the file upload page' do
      visit '/upload'
      expect(page).to have_content('Upload')
    end

    it 'renders without error' do
      visit '/upload'
      expect { page }.to_not raise_error
    end
  end

  scenario 'when I click the create audio file button after selecting a file' do
  end

  it 'creates an audio record and uploads the file to storage' do
    visit '/upload'
    attach_file 'audio_file[audio]', support_file('test-file.wav')
    click_button "Create Audio file"
    expect(page).to have_content('Transcriptor')
  end
end
