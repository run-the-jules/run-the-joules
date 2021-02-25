class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :username, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  validates :password, presence: true, confirmation: true
end
