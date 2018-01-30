require 'rails_helper'

RSpec.describe AudioFile, type: :model do
  it "is valid and has a valid email" do
    audio_file = AudioFile.new(email: 'hello@email.com')
    expect(AudioFile.new).to be_valid
    expect(audio_file.email).to eq('hello@email.com')
  end
end
