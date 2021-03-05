class Users::FriendsController < ApplicationController
  def search
    friend = User.find_by(email: params[:query])

    if friend
      FriendsFacade.create_friendship(current_user.id, friend.id)
      flash[:succes] = "You are now following #{friend.full_name}!"
      redirect_to dashboard_index_path
    else
      flash[:error] = "User doesn't exist!"
      redirect_to dashboard_index_path
    end
  end
end