class Users::DashboardController < ApplicationController

  def index
    begin
      if params[:referral]
        @data_info_usage = UsersService.get_meters(params[:referral])
      else
        @data_info_usage = UsersFacade.find_usage(params[:id])
      end
    rescue
      {"error" => "Something went wrong."}
    end
  end
end