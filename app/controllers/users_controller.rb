class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  include Wunderground

  # == GET /home
  def home
    puts "\n******** home ********"
    current_user = nil
    puts "*** current_user.inspect: #{current_user.inspect} ***"
    @users = User.all
    puts "*** current_user.inspect: #{current_user.inspect} ****"
    # puts "*** current_user[:id].inspect: #{current_user[:id].inspect} ****"
  end

  # == GET /landing
  def landing
    puts "\n******** landing ********"
    @user = User.find(current_user.id)
  end

  # == GET /weather_underground
  def weather_underground
    puts "\n******** weather_underground ********"
    @radar = Wunderground.animated_radar_api_response
    puts "@radar.inspect #{@radar.inspect}"
  end

  # ======= current user checks clicked user's profile =======
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
    # @photo = Photo.where(user_id: current_user.id).first
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
end
