# ======= ======= ======= google_places.rb ======= ======= =======
module Google_places

    BASE_SEARCH_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"

    def self.places_api_response(search_term)
        puts "\n******* Google_places:places_api_response *******"

        remote_url = BASE_SEARCH_URL
        remote_url += search_term
        HTTParty.get(remote_url)
    end

end
