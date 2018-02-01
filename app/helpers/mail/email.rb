require 'sendgrid-ruby'
include SendGrid

from = Email.new(email: 'test@example.com')
subject = 'Transcription completed'
to = Email.new(email: @audio_file.email)
content = Content.new(type: 'text/plain', value: "Your audio file was transcribed on #{@audio_file.created_at}.\n
Filename: #{@audio_file.audio_file_name}")
mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers
