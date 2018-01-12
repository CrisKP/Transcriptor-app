class AudioFile < ActiveRecord::Base
  has_attached_file :audio
  validates_attachment :audio, content_type: { content_type:['audio/x-wav']}
end
