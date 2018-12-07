class ReviewsController < ApplicationController

  def index
    @reviews = Review.all.order(created_at: :desc)
  end

  def show
    # @product = Product.find params[:id]
    @review = Review.find_by(product_id: @product.ids)
  end
end
