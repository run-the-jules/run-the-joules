class Users::FriendsController < ApplicationController
  def index

    # needs to get most recent record for each friend -- backend endpoint?
    @friends = current_user.friends
  end

  def search
    friend = User.find(params[:query])

    if friend
      # hit backend endpoint to create follow relationship
      FriendsFacade.create_friendship(current_user.id, friend.id)
      flash[:succes] = "You are now following #{friend.full_name}!"
      redirect_to user_friends_path(current_user)
    else
      flash[:error] = "User doesn't exist!"
      redirect_to user_friends_path(current_user)
    end
  end
end