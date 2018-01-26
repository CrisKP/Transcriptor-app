require 'rails_helper'
require 'service/google'

module Service
  RSpec.describe Google do
    let(:tran)       { Google.new(file_path) }
    let(:file_path)  { Rails.root.join('spec/support/test-file.wav') }
    let(:results)    { tran.transcripts }
    let(:transcript) { results.first }

    let(:fake_credentials) { double(:fake_credentials) }
    let(:fake_audio)       { double(:fake_audio, process: fake_operation) }
    let(:fake_speech)      { double(:fake_speech, audio: fake_audio) }
    let(:fake_result) do
      double(:fake_result, transcript: "yeah that's a weird", confidence: 0.99)
    end
    let(:fake_operation) do
      double(:fake_operation, wait_until_done!: ->{ true }, results: [fake_result])
    end

    before do
      allow(::Google::Cloud::Speech::Credentials)
        .to receive(:new)
        .with(Service::Google::CREDENTIALS)
        .and_return fake_credentials

      allow(::Google::Cloud::Speech)
        .to receive(:new)
        .with(project_id: Service::Google::PROJECT_ID,
          credentials: fake_credentials)
        .and_return(fake_speech)
    end

    it 'outputs a valid transcript' do
      expect(results.length).to eq 1
    end

    it 'includes path, transcript and confidence score' do
      expect(transcript[0]).to match /test-file.wav/
      expect(transcript[1]).to match /yeah that's a weird/
      expect(transcript[2]).to be_a Float
    end
  end
end
