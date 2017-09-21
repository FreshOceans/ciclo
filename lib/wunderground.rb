# ======= ======= ======= wunderground.rb ======= ======= =======
module Wunderground

    BASE_SEARCH_URL = "http://api.wunderground.com/api/"

    def self.animated_radar_api_response(search_radar)
        puts "\n******* WeatherUnderground:animated_radar_api_response *******"

        remote_url = BASE_SEARCH_URL
        remote_url += search_radar

        puts "+*** remote_url: #{remote_url.inspect} ***+"
        response = HTTParty.get(remote_url)
        return response
    end

end
