class MainController < ApplicationController
  def index
    @audio_file = AudioFile.new
  end

  def create
    @audio_file = AudioFile.create(audio_file_params)
    @audio_file.save
    flash[:success] = "File \"#{@audio_file.title}\" has been received and queued for transcription."
    redirect_to :root
  end

  private

  def audio_file_params
    params.require(:audio_file).permit(:audio, :title)
  end
end
