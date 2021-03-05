class Users::DashboardController < ApplicationController
  before_action :check_user
  before_action :check_household

  def index
    begin
      @data_info_usage = DashboardFacade.build_usages(params, current_user)
      @users_usages = UsersService.call_utility(current_user.id)[:data]
      @friends = current_user.friends
    rescue
    end
  end

  private

  def check_household
    redirect_to edit_user_path(current_user) unless current_user.household_size
  end
end