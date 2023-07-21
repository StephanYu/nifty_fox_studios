class MoviesController < ApplicationController
  before_action :set_movie, except: [:index]
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  
  def index
    case params[:query]
    when "upcoming"
      @movies = Movie.upcoming
    when "recent"
      @movies = Movie.recent
    else
      @movies = Movie.released
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @movies }
    end
  end

  def new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      respond_to do |format|
        format.html { redirect_to @movie, notice: "Movie successfully created!" }
        format.json { render json: @movie }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @movie }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: "Update successful!" }
        format.json { render json: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie successfully deleted!" }
      format.json { head :no_content }
    end
  end

  private

    def movie_params
      params.require(:movie).permit(:title, :description, :rating, :release_year, :director, :main_image)
    end

    def set_movie
      @movie = Movie.find_by!(slug: params[:id])
    end
end
