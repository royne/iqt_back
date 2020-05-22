class Api::V1::MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :update, :destroy]

  def index
    @movies = Movie.all

    render json: @movies
  end

  def search
    @movies = Movie.all
    @movies = @movies.where("title Ilike ?", "%#{params[:title]}%") if params[:title].present?
    @movies = @movies.where("overview Ilike ?", "%#{params[:overview]}%") if params[:overview].present?
    @movies = @movies.where(vote_count: params[:vote_count]) if params[:vote_count].present?
    if params[:release_date_start].present? && params[:release_date_end].present?
      @movies = @movies.where(release_date: (params[:release_date_start]..params[:release_date_end]))
    elsif params[:release_date_start].present?
      @movies = @movies.where(release_date: params[:release_date_start]) if params[:release_date_start].present?
    end

    render json: @movies
  end
  
  def show
    render json: @movie
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render json: @movie, status: :created
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:id_movie, :title, :overview, :vote_count, :poster_path, :release_date)
    end
end
