class ReviewsController < ApplicationController
  before_action :set_movie
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @reviews = @movie.reviews

    respond_to do |format|
      format.html
      format.json { render json: @reviews }
    end
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to movie_reviews_path(@movie), notice: "Thanks for your review!" }
        format.json { render json: @review, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def review_params
      params.require(:review).permit(:name, :stars, :comment)
    end

    def set_movie
      @movie = Movie.find_by!(slug: params[:movie_id])
    end
end
