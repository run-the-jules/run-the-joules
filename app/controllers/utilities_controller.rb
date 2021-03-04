class UtilitiesController < ApplicationController
  def index
    email = current_user.email
    utility = params[:utility]
    data = UsersService.new_user_utility(email, utility)
    redirect_to data
  end
end
