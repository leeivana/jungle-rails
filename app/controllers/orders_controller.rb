class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    # @product = LineItem.select('product_id').find_by(order_id: @order.id)
    # puts "PRODUCT ID: #{@product}"
    # select product_id from line_items where order_id = @order.id;



    # @product_id = LineItem.select("product_id").where(order_id: @order.id)
    # @item = Product.where(id: @product.ids)

# NEED TO DO :
# given order id
# select product_id, quantity from line_items where order_id = @order.id;
# --> this will get productid and quantity for each item
# given the productid numbers --> retrieve information from product table for image, name description

  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

end
