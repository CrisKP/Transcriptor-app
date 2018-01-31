RSpec.shared_context 'an api call' do
  let(:fake_credentials) { double(:fake_credentials) }
  let(:fake_audio)       { double(:fake_audio, process: fake_operation) }
  let(:fake_speech)      { double(:fake_speech, audio: fake_audio) }
  let(:fake_result) do
    double(:fake_result,
      transcript: "random example text",
      confidence: 0.99)
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
end
