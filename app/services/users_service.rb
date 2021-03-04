class UsersService
  class << self
    def call_utility(id)
      response = conn.get("/api/v1/usages/#{id}") do |request|
        request.params[:id] = id
      end
      parse_data(response)
    end

    def get_friends(id)
      response = conn.get("/api/v1/friendships") do |request|
        request.params[:user_id] = id
      end

      data = parse_data(response)
      
      data[:data][:attributes][:friends_data].map do |data|
        MonthlyUsage.new(data)
      end
    end

    def fetch_utilities
      response = conn.get("/api/v1/providers")
      parse_data(response)
    end

    def new_user_utility(email, utility)
      response = conn.get('/api/v1/new_users') do |request|
        request.params[:email] = email
        request.params[:utility] = utility
      end
      response.body
    end

    def get_meters(params)
      response = conn.get('/api/v1/get_meters') do |request|
        request.params[:referral] = params[:referral]
        request.params[:id] = params[:id]
      end
      parse_data(response)
    end

    def get_usages(user_id)
      response = conn.get('/api/v1/get_bills') do |request|
        request.params[:user_id] = user_id
      end
      parse_data(response)
    end

    private

    def conn
      Faraday.new("https://jules-api.herokuapp.com")
    end

    def parse_data(data)
      JSON.parse(data.body, symbolize_names: true)
    end
  end
end
