class UsersController < ApplicationController
  def dashboard
    @data_info_usage = if params[:referral]
      UsersService.get_meters(params[:referral])
    else
      UsersFacade.find_usage(params[:id])
    end
  end

  def new 
    redirect_to root_path if current_user
  end
  
  def edit; end

  def update; end
end
