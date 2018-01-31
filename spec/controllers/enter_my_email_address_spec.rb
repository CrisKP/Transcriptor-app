require 'rails_helper'

RSpec.describe AudioFile, type: :model do
  it "is valid and has a valid email" do
    audio_file = AudioFile.new(email: 'hello@email.com')
    expect(audio_file).to be_valid
    expect(audio_file.email).to eq('hello@email.com')
  end
end
