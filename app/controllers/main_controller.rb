class MainController < ApplicationController
  def index
    @audio_file = AudioFile.new
  end

  def create
    @audio_file = AudioFile.create(audio_file_params)
    redirect_to :root
  end

  private

  def audio_file_params
    params.require(:audio_file).permit(:audio)
  end
end
