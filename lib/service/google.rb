require 'google/cloud/speech'

module Service
  class Google
    Speech      = ::Google::Cloud::Speech
    PROJECT_ID  = ENV['GOOGLE_CLOUD_PROJECT_ID']
    CREDENTIALS = {
      'type'           => 'service_account',
      'private_key_id' => ENV['GOOGLE_CLOUD_PRIVATE_KEY_ID'],
      'private_key'    => ENV['GOOGLE_CLOUD_PRIVATE_KEY'],
      'client_id'      => ENV['GOOGLE_CLOUD_CLIENT_ID'],
      'client_email'   => ENV['GOOGLE_CLOUD_CLIENT_EMAIL'],
      'auth_uri'       => 'https://accounts.google.com/o/oauth2/auth',
      'token_uri'      => 'https://accounts.google.com/o/oauth2/token',
      'auth_provider_x509_cert_url' => 'https://www.googleapis.com/oauth2/v1/certs',
      'client_x509_cert_url' => 'https://www.googleapis.com/robot/v1/metadata/x509/1073999425707-compute%40developer.gserviceaccount.com'
    }
    AUDIO_OPTS = {
      encoding: :linear16,
      language: "en-US",
      sample_rate: 32000
    }

    def initialize(file_path, options={})
      @file_path = file_path
      @options   = options
    end

    def transcripts
      results.map do |res|
        [file_path.to_path, res.transcript, res.confidence]
      end
    end

    private

    attr_reader :file_path, :options

    def speech_client
      Speech.new project_id: PROJECT_ID,
        credentials: Speech::Credentials.new(CREDENTIALS)
    end

    def audio
      speech_client.audio file_path, AUDIO_OPTS.merge(options)
    end

    def results
      operation = audio.process
      operation.wait_until_done!
      operation.results
    end
  end
end
