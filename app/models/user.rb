class User < ActiveRecord::Base
    has_secure_password

    has_many :reviews

    validates :first, presence: true
    validates :last, presence: true
    validates :email, presence: true, uniqueness: true
    validates_length_of :password, minimum: 6, maximum: 15, allow_blank: false
    validates :password, presence: true
    validates :password_confirmation, presence: true

    def self.authenticate_with_credentials(email, password)
      find_user = User.find_by_email(email.downcase)
      true if find_user&.authenticate(password)
      # raise "Invalid email or password" if user.nil? or not user.authenticate password
    end
end
