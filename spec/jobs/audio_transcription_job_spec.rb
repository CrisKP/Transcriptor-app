require 'rails_helper'

RSpec.describe AudioTranscriptionJob, type: :job do
  include_context 'an api call'

  let(:local_file_path) { File.new("spec/support/test-file.wav") }
  let(:audio_file) { AudioFile.create audio: local_file_path }

  before do
    AudioTranscriptionJob.perform_now audio_file.id
    audio_file.reload
  end

  it 'updates start and complete datetime fields' do
    expect(audio_file.transcription_started_at).to_not be_blank
    expect(audio_file.transcription_completed_at).to_not be_blank
  end

  it 'records the transcription to the audio file' do
    expect(audio_file.transcription).to_not be_blank
  end

  it 'records the confidence score to the audio file' do
    expect(audio_file.confidence).to_not be_blank
  end
end
