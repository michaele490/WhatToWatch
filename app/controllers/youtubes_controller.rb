class YoutubesController < ApplicationController
  before_action :set_youtube, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @youtubes = current_user.youtubes
  end

  def show
  end

  def new
    @youtube = current_user.youtubes.build
  end

  def create
    @youtube = current_user.youtube.build(youtube_params)
    if @youtube.save
      redirect_to @youtube, notice: "Youtube video was successfully added"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @youtube.update(youtube_params)
      redirect_to @youtube, notice: "Youtube video was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @youtube.destroy
    redirect_to youtubes_url, notice: "Youtube video was successfully removed."
  end

  private

  def set_youtube
    @youtube = current_user.youtubes.find(params[:id])
  end

  def youtube_params
    params.require(:youtube).permit(:title, :genre)
  end
end
