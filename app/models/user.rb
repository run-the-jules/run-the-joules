class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end

  def find_friends
    friends_data = UsersService.get_friends(self.id)
    require 'pry'; binding.pry
  end
end
