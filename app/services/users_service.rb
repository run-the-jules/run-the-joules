class UsersService
  class << self
    def call_utility(id)
      response = conn.get("/api/v1/#{id}")
      parse_data(response)
    end

    def fetch_utilities
      param = true
      response = conn.get("/api/v1/meter_activation?utilities=#{param}")
      parse_data(response)
    end

    def new_user_utility(email, utility)
      response = conn.get('/api/v1/meter_activation') do |request|
        request.params[:email] = email
        request.params[:utility] = utility
      end
      parse_data(response)
    end

    def get_meters(referral)
      response = conn.get('api/v1/meter_activation') do |request|
        request.params[:referral] = referral
      end
      parse_data(response)
    end

    private

    def conn
      Faraday.new('https://mysterious-ravine-39718.herokuapp.com')
    end

    def parse_data(data)
      JSON.parse(data.body, symbolize_names: true)
    end
  end
end
