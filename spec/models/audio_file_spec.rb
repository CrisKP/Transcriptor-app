require 'rails_helper'

RSpec.describe AudioFile do
  include ActiveJob::TestHelper
  
  describe 'after_create' do
    it 'enques a transcription job' do
      expect {
        AudioFile.create
      }.to have_enqueued_job(AudioTranscriptionJob)
    end
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
