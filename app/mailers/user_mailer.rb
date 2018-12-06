class UserMailer < ApplicationMailer
  def confirmation_email(current_user, order)
    @order = order
    mail(to: current_user, subject: "Order Confirmation Email for Order #{order.id}")
  end

end
