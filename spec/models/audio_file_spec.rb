require 'rails_helper'

RSpec.describe AudioFile do
  describe 'after_create' do
    it 'enques a transcription job' do
      expect {
        AudioFile.create
      }.to have_enqueued_job(AudioTranscriptionJob)
    end
  end
end
