class Users::DashboardController < ApplicationController
  before_action :check_user
  before_action :check_household

  def index
    params[:id] = current_user.id
    if current_user.friends
       @friends = UsersFacade.friends_usage(current_user.friends)
    end
    begin
      if params[:referral]
        UsersService.get_meters(params)
        @data_info_usage = UsersService.get_usages(current_user.id)
      else
        @data_info_usage = UsersFacade.find_usage(current_user.id)
      end
    rescue
      {"error" => "Something went wrong."}
    end
  end

  private

  def check_household
    redirect_to edit_user_path(current_user) unless current_user.household_size
  end
end