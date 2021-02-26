class UsersService
  class << self
    def call_utility(id, size)
      response = conn.get("/api/v1/#{id}&household_size=#{size}")
      parse_data(response)
    end

    private
    def conn
      Faraday.new("https://mysterious-ravine-39718.herokuapp.com")
    end

    def parse_data(data)
      JSON.parse(data.body, symbolize_names: true)
    end
  end
end
