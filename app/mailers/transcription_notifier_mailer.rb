class TranscriptionNotifierMailer < ApplicationMailer
   def transcription_email(audio_file)
     @audio_file = audio_file
     mail( :to => @audio_file.email,
     :subject => 'Transcription completed' )
   end
end
