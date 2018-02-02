require 'rails_helper'
require 'service/google'

module Service
  RSpec.describe Google do
    ## COMMENT TO ENABLE (SANITY CHECK) THE REAL IMPLIMENTATION
    include_context 'an api call'

    let(:tran)       { Google.new(file_path) }
    let(:file_path)  { Rails.root.join('spec/support/test-file.wav') }
    let(:results)    { tran.transcripts }
    let(:transcript) { results.first }

    it 'outputs a valid transcript' do
      expect(results.length).to eq 1
    end

    it 'includes path, transcript and confidence score' do
      expect(transcript.path).to eq file_path
      expect(transcript.text.downcase).to be_present
      expect(transcript.confidence).to be_a Float
    end
  end
end
