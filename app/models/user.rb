class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false

  def self.from_google(email:, full_name:, uid:)
    create_with(uid: uid, full_name: full_name).find_or_create_by!(email: email)
  end

  def friends
    friendships = UsersService.get_friends(id)[:data]
    friend_ids = friendships.map { |friendship| friendship[:attributes][:following_id] }
    User.where(id: friend_ids)
  end
end
