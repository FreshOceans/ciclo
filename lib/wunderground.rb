# ======= ======= ======= wunderground.rb ======= ======= =======
module Wunderground

    # BASE_SEARCH_URL = "http://api.wunderground.com/api/4ac6165543934cf3/animatedradar/q/MI/Ann_Arbor.gif?newmaps=1&timelabel=1&timelabel.y=10&num=5&delay=50"

    def self.animated_radar_api_response()
        puts "\n******* WeatherUnderground:animated_radar_api_response *******"

        base_search_url = "http://api.wunderground.com/api/4ac6165543934cf3/animatedradar/q/"
        location = "VA/Alexandria"
        params = "newmaps=1&timelabel=1&timelabel.y=10&num=5&delay=50"
        url_array = [base_search_url, location, ".png?", params]
        url_array.join
        puts "url_array.join: #{url_array.join}"

        HTTParty.get(url_array.join)
    end

end
