class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @product = Product.find_by(id: params[:id])
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product), notice: 'Review successfully posted.'
      render :show, status: :created, location: @review
    else
      render :new
    end

  end

  private
  def review_params
    review = params.require(:review).permit(
      :description,
      :rating
    )
    review[:product_id] = params[:product_id]
    review
  end

end

