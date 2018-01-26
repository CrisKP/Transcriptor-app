class AudioTranscriptionJob < ApplicationJob
  queue_as :default

  def perform(audio_file_id)
    puts audio_file_id
  end
end
