class User < ActiveRecord::Base
  has_many :articles
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :name , presence: true, uniqueness: true , length: { maximum: 100 }
  validates :email, uniqueness: { case_sensitive: false }, length: { maximum: 100 },
      format: { with: VALID_EMAIL_REGEX }
  validates :password , presence: true, 
  	confirmation: true, length: { in: 6..100 }
  validates :password_confirmation , presence: true	
  has_secure_password
end
