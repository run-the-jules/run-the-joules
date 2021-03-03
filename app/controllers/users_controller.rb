class UsersController < ApplicationController
  def new 
    redirect_to root_path if current_user
  end
  
  def edit; end

  def update
    current_user.update(user_params)
    redirect_to dashboard_index_path
  end
  
  private

  def user_params
    params.require(:user).permit(:household_size, :total_points)
  end
end
