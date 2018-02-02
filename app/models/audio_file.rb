class AudioFile < ApplicationRecord
  has_attached_file :audio
  validates_attachment :audio, content_type: { content_type: ['audio/x-wav'] }

  after_commit :transcribe, on: :create

  private

  def transcribe
    AudioTranscriptionJob.perform_later(self.id)
  end
end
