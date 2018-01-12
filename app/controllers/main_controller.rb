class MainController < ApplicationController
  def index
    # binding.pry
    @audio_files = AudioFile.all
  end

  def create
    @audio_file = AudioFile.create(audio_file_params)
    redirect_to :root
  end

  def new
      @audio_file = AudioFile.new
  end

private

  def audio_file_params
    params.require(:audio_file).permit(:audio, :name)
  end

end
