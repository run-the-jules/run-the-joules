class UsersController < ApplicationController
  def dashboard
    @data_info_usage = if params[:referral]
      UsersService.get_meters(params[:referral])
    else
      UsersFacade.find_usage(params[:id])
    end
  end

  def edit; end

  def update; end
end
