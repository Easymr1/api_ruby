class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    before_save { email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 250 },
                        format: { with: VALID_EMAIL_REGEX},
                        uniqueness: true

    has_secure_password

end
