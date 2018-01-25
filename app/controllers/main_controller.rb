class MainController < ApplicationController
  def index
    @audio_file = AudioFile.new
  end

  def create
    @audio_file = AudioFile.create(audio_file_params)
    if @audio_file.save
      flash[:success] = "\"#{@audio_file.title}\" transcription sent to alfonso@codingzeal.com!"
      redirect_to :root
    else
      redirect_to :root
    end
  end

  private

  def audio_file_params
    params.require(:audio_file).permit(:audio, :title)
  end
end
