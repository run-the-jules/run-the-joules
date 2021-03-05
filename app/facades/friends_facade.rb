class FriendsFacade
  def self.create_friendship(user_id, follow_id)
    # response = Faraday.post('https://jules-api.herokuapp.com/api/v1/friendships') do |req|
    #   req.params['user_id'] = user_id
    #   req.params['following_id'] = follow_id
    #   req.headers['CONTENT_TYPE'] = 'application/json'
    # end

    UsersService.create_friendship(follow_id, user_id)
  end
end