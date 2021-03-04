class Users::FriendsController < ApplicationController
  def index
    @friends = current_user.find_friends 
  end
end