module ApplicationHelper
  def provider_list
    begin
      UsersService.fetch_utilities[:data]
    rescue
      [{"nil" => "nil"}]
    end
  end
end
