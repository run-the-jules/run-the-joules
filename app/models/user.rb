class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_secure_password

  validates :email, presence: true
  validates :username, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  validates :password, presence: true, confirmation: true
end
