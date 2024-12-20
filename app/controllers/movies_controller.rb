class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @movies = current_user.movies
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = current_user.movies.build
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie was successfully added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_url, notice: "Movie was successfully removed."
  end

  private

  def set_movie
    @movie = current_user.movies.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :genre, :user_id)
  end
end
