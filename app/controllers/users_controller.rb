class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # include Wunderground
  include Google_places

  # == GET /home
  def home
    puts "\n******** home ********"
    current_user = nil
    puts "*** current_user.inspect: #{current_user.inspect} ***"
    @users = User.all
    puts "*** current_user.inspect: #{current_user.inspect} ****"
    # puts "*** current_user[:id].inspect: #{current_user[:id].inspect} ****"
  end

  # ==== Google Places API: Bicycle Shops ====
  # GET /find_bicycle_shops_ajax
  def find_bicycle_shops_ajax
    gon.shop_presence = true
    puts "\n******* find_bicycle_shops_ajax *******"
    # puts "find_bicycle_shops_ajax_params.inspect: #{find_bicycle_shops_ajax_params.inspect}"
    puts "params.inspect #{params.inspect}"
    permitted_params = find_bicycle_shops_ajax_params
    # puts "== permitted_params.inspect: #{permitted_params.inspect}"
    geolocation = permitted_params[:lat] +  "," + permitted_params[:lng]
    puts "geolocation: #{geolocation}"
    search_bicycle_shops = find_local_bicycle_shops(geolocation)
    #   search_bicycle_shops = find_local_bicycle_shops(permitted_params[:geolocation])
    json_data = Google_places.places_api_response(search_bicycle_shops)
    @place_data_array = json_data['results']
    puts "@@place_data_array, #{@place_data_array.inspect}"

    # == map data source via google maps
    # render "local_bicycle_shops"
    respond_to do |format|
        format.json {
            render json: {:place_data_array => @place_data_array}
        }
    end
  end

  # GET /find_local_bicycle_shops
  def find_local_bicycle_shops(geolocation)
      puts "\n******* find_local_bicycle_shops *******"

      # == search for bicycle_shops locations within 804meters(0.5mi) of geolocation
      location = geolocation
      puts "||| location: #{location} |||"
      radius = "804"
      types = "bicycle_shop"
      name = "bike_repair"
      key = GOOGLE_PLACES_KEY

      search_bicycle_shops = "location=" + location
      search_bicycle_shops += "&radius=" + radius
      search_bicycle_shops += "&types=" + types
      search_bicycle_shops += "&name=" + name
      search_bicycle_shops += "&key=" + key

      puts "+=+ search_bicycle_shops.inspect #{search_bicycle_shops.inspect}+=+"

      return search_bicycle_shops
  end

  # GET /make_local_map
  # def make_local_map
  #     puts "\n******* make_local_map *******"
  #
  #     # == search for bicycle_shops locations within 804meters(0.5mi) of geolocation
  #     location = get_lat_lon()
  #
  #     key = GOOGLE_MAPS_KEY
  #     remote_url = "https://www.google.com/maps/embed/v1/place"
  #     remote_url += "?key=" + key
  #     remote_url += "&q=" + location
  #     puts "remote_url: #{remote_url.inspect}"
  #     return remote_url
  # end

  # ===== Weather Underground API: Radar & Hourly Forecast ====
  # GET /weather_underground
  def weather_underground
    puts "\n******** weather_underground ********"
    gon.wu_presence = true
    search_radar = wu_radar_constructor
    puts "search_radar.inspect: #{search_radar.inspect}"
    @wu_radar = wu_radar_constructor
    puts "@wu_radar.inspect #{@wu_radar.inspect}"
  end

  # GET /wu_hourly_constructor
  def wu_hourly_constructor
      puts "\n******* wu_hourly_constructor *******"

       base_search_url = "http://api.wunderground.com/api/"
       key = WEATHER_UNDERGROUND_KEY
       feature = "/hourly/q/"
       location = "/DC/Washington.json"

       search_hourly = base_search_url
       search_hourly += key
       search_hourly += feature
       search_hourly += location

       puts "+=+ search_hourly.inspect: #{search_hourly.inspect}+=+"

       response = HTTParty.get(search_hourly)

       respond_to do |format|
           format.json {
               render json: {:hourly_data => response}
           }
       end
  end

  # GET /wu_radar_constructor
  def wu_radar_constructor
      puts "\n******* wu_radar_constructor *******"

      base_search_url = "http://api.wunderground.com/api/"
      key = WEATHER_UNDERGROUND_KEY
      feature = "/animatedradar/q/"
      location = "/DC/Washington"
      wu_format = ".gif?"
      params = "newmaps=1&timelabel=1&timelabel.y=10&num=5&delay=50"

      search_radar = base_search_url
      search_radar += key
      search_radar += feature
      search_radar += location
      search_radar += wu_format
      search_radar += params

      puts "+=+ search_radar.inspect #{search_radar.inspect}+=+"

      return search_radar
  end

  # == GET /landing
  def landing
    puts "\n******** landing ********"
    @user = User.find(current_user.id)
  end

  # GET /check_user
  def check_user
      puts "\n******* check_user *******"
      @check_user = User.find(params[:id])
      @check_user_reports = Report.where(user_id: @check_user.id)
      puts "******* @check_user_reports: #{@check_user_reports.inspect}"
  end

  # GET /users
  # GET /users.json
  def index
    puts "\n******** user_index ********"
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    puts "\n******** user_show ********"
    @user = User.find(params[:id])
    @photo = Photo.where(user_id: current_user.id).first
    @user_reports = Report.where(user_id: current_user.id)
    puts "******* @user_reports: #{@user_reports.inspect}"
  end

  # GET /users/new
  def new
    puts "\n******** user_new ********"
    puts "*** @user.inspect, #{@user.inspect} ***"
    puts "*** params.inspect, #{params.inspect} ***"
    @user = User.new
    puts "@user.firstname: #{@user.firstname}"
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    puts "\n******** user_create ********"
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to '/landing', notice: 'User was successfully created an account.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to '/', notice: 'User not created' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    puts "\n******** user_delete ********"
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      puts "\n******** set_user ********"
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      puts "\n******** user_params ********"
    #   params.fetch(:user, {})
    end

    def find_bicycle_shops_ajax_params
      puts "\n******** find_bicycle_shops_ajax_params ********"
      params.permit(:lat, :lng)
    end
end
