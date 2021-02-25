class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :registerable,
  # devise :database_authenticatable,
  #        :recoverable, :rememberable, :validatable, :omniauthable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end
end
