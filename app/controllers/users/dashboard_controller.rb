class Users::DashboardController < ApplicationController

  def index
    if params[:referral]
      @data_info_usage = UsersService.get_meters(params[:referral])
    else
      @data_info_usage = UsersFacade.find_usage(params[:id])
    end
  end
end