class TranscriptionNotifierMailer < ApplicationMailer
   def transcription_email(audio_file)
     @audio_file = audio_file

     attachments["#{@audio_file.title}.txt"] = {
       mime_type: 'text/plain',
       content: @audio_file.transcription
     }

     mail to: @audio_file.email, subject: 'Transcription completed'
   end
end
