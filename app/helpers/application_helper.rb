module ApplicationHelper
  def provider_list
    UsersService.fetch_utilities[:data]
    # rescue [{"attributes" => {"name" => "Utilities not found", "id" => "nil"}}]
  end
end
