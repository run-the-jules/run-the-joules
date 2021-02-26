class UsersController < ApplicationController
  def dashboard
    @data_info_usage = UsersFacade.find_usage(params[:id], current_user.household_size)
  end
end
