require 'rails_helper'

RSpec.describe AudioFile, :type => :model do
  it "is valid and can be given a title" do
    audio_file = AudioFile.new(title: 'Test Title')
    expect(AudioFile.new).to be_valid
    expect(audio_file.title).to eq('Test Title')
  end
end
