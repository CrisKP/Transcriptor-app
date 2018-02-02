class MainController < ApplicationController
  def index
    @audio_file = AudioFile.new
  end

  def create
    @audio_file = AudioFile.create(audio_file_params)
    @audio_file.save
    flash[:success] = "\"#{@audio_file.title}\" transcription sent to #{@audio_file.email}!"
    redirect_to :root
  end

  private

  def audio_file_params
    params.require(:audio_file).permit(:audio, :title, :email)
  end
end
