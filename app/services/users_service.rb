class UsersService
  class << self
    def call_utility(id)
      response = conn.get("/api/v1/usages") do |request|
        request.params[:id] = id
      end
      parse_data(response)
    end

    def fetch_utilities
      response = conn.get("/api/v1/providers")
      parse_data(response)
    end

    def new_user_utility(email, utility)
      response = conn.get('/api/v1/new_user') do |request|
        request.params[:email] = email
        request.params[:utility] = utility
      end
      parse_data(response)
    end

    def get_meters(referral)
      response = conn.get('/api/v1/get_meters') do |request|
        request.params[:referral] = referral
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
      Faraday.new(ENV['BACKEND_API'])
    end

    def parse_data(data)
      JSON.parse(data.body, symbolize_names: true)
    end
  end
end
