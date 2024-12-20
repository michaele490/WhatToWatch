class TvShowsController < ApplicationController
  before_action :set_tv_show, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @tv_shows = current_user.tv_shows
  end

  def show
    # @tv_show = TvShow.find(params[:id])
  end

  def new
    @tv_show = current_user.tv_shows.build
  end

  def create
    @tv_show = current_user.tv_shows.build(tv_show_params)
    if @tv_show.save
      redirect_to @tv_show, notice: "TV show was successfully added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @tv_show.update(tv_show_params)
      redirect_to @tv_show, notice: "TV show was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tv_show.destroy
    redirect_to tv_shows_url, notice: "TV show was successfully removed."
  end

  private

  def set_tv_show
    @tv_show = current_user.tv_shows.find(params[:id])
  end

  def tv_show_params
    params.require(:tv_show).permit(:title, :genre, :minutesPerEpisode, :seasons, :seasonsCompleted, :user_id)
  end
end
