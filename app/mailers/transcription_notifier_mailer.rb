class TranscriptionNotifierMailer < ApplicationMailer
  default :from => 'any_from_address@example.com'

   def transcription_email(audio_file)
     @audio_file = audio_file
     mail( :to => @audio_file.email,
     :subject => 'Transcription completed' )
   end
end
