class User < ActiveRecord::Base
    has_secure_password

    has_many :reviews

    validates :first, presence: true
    validates :last, presence: true
    validates :email, presence: true, uniqueness: true
    validates_length_of :password, minimum: 6, maximum: 15, allow_blank: false
    validates :password, presence: true
    validates :password_confirmation, presence: true
end
