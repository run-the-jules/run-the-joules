class UtilitiesController < ApplicationController
  def index
    binding.pry
    email = current_user.email
    utility = params[:provider]
    data = UsersService.new_user_utility(email, utility)
    redirect_to data[:url]
  end
end
