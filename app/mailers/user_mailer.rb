class UserMailer < ApplicationMailer

  def confirmation_email(current_user)
    @current_user = current_user
    mail(to: @current_user.email, subject: 'Order Confirmation Email')
  end

end
