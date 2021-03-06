class ReviewsController < ApplicationController
 before_filter :authorize, :only => [:create, :delete]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @product = Product.find_by(id: params[:product_id])
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product), notice: 'Review created successfully'
    else
      render :new
    end

  end

  def destroy
      @review = Review.find_by(id: params[:id])
      @product = Product.find_by(id: params[:product_id])
    if current_user.id == @review.user_id
      @review.destroy
      redirect_to product_path(@product), notice: 'Review deleted'
    else
      redirect_to product_path(@product)
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

