require 'service/google'

class AudioTranscriptionJob < ApplicationJob
  class S3TempFile
    def initialize(s3_file)
      @s3_file = s3_file
    end

    def to_path
      write_s3_file_to_tmp! unless File.exist? tmp_file_path
      tmp_file_path
    end

    private

    attr_reader :s3_file

    def write_s3_file_to_tmp!
      puts ">> Make tmp directory"
      FileUtils.mkdir_p tmp_file_path_dir

      puts ">> Copy file to #{tmp_file_path}"
      s3_file.copy_to_local_file :original, tmp_file_path
    end

    def tmp_file_path_dir
      Rails.root.join 'tmp', File.dirname(tmp_safe_s3_file_path)
    end

    def tmp_file_path
      File.join tmp_file_path_dir, File.basename(tmp_safe_s3_file_path)
    end

    def tmp_safe_s3_file_path
      # removes the leading slash
      s3_file.path.match(/\A\/(.*)\z/)[1]
    end
  end

  queue_as :default

  def perform(file_id)
    attempt do
      audio_file = AudioFile.find(file_id)

      puts ">> Starting transcription for #{audio_file.id}"
      audio_file.touch(:transcription_started_at)

      s3_temp_file  = S3TempFile.new audio_file.audio
      google        = Service::Google.new(s3_temp_file.to_path)

      record_transcription audio_file, google

      puts ">> Emailing transcription for #{audio_file.id}"
      TranscriptionNotifierMailer
        .transcription_email(audio_file)
        .deliver_now
    end
  end

  private

  def attempt(limit = 3)
    attempts = 0
    begin
      attempts += 1
      puts ">> Starting attempt #{attempts}"
      sleep 1
      yield
    rescue ActiveRecord::RecordNotFound
      retry if attempts < limit
    end
  end

  def record_transcription(audio_file, service)
    service.transcripts.each do |t|
      puts ">> Recording transcription for #{audio_file.id}"
      audio_file.transcription              = t.text
      audio_file.confidence                 = t.confidence
      audio_file.transcription_completed_at = DateTime.now
      audio_file.save!
    end
  end
end
