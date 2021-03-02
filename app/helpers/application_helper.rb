module ApplicationHelper
  def provider_list
    UsersService.fetch_utilities[:data]
  end
end
