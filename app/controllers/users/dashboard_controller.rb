class Users::DashboardController < ApplicationController

  def index
    params[:id] = current_user.id
    begin
      if params[:referral]
        meter = UsersService.get_meters(params)
        @data_info_usage = UsersService.get_usages(current_user.id)
      else
        @data_info_usage = UsersFacade.find_usage(current_user.id)
      end
    rescue
      {"error" => "Something went wrong."}
    end
  end
end