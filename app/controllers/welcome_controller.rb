class WelcomeController < ApplicationController
  def index
    redirect_to dashboard_index_path if current_user
  end

  def contact; end

  def about; end
end
