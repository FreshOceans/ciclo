class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def home
    puts "\n******** home ********"
    current_admin = nil
    puts "*** current_admin.inspect: #{current_admin.inspect} ***"
    @admins = Admin.all
    puts "*** current_admin.inspect: #{current_admin.inspect} ****"
    # puts "*** current_user[:id].inspect: #{current_user[:id].inspect} ****"
  end

  # == GET /landing
  def admin_landing
    puts "\n******** admin_landing ********"
    @admin = Admin.find(current_admin.id)
  end

  # GET /admins
  # GET /admins.json
  def index
    puts "\n******** admin_index ********"
    @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
    puts "\n******** admin_show ********"
    # puts "*** @admin.inspect, #{@admin.inspect} ***"
    # puts "*** params.inspect, #{params.inspect} ***"
    @admin = Admin.find(params[:id])
    # puts "@admin.firstname: #{@admin.firstname}"
  end

  def admin_user
      puts "\n******** admin_user *******"
      @users = User.find(params[:id])
      @user_reports = Report.where(user_id: @users.id)
      puts "===**** @user_reports: #{@user_reports.inspect} ===****"
  end

  # GET /admins/new
  def new
    puts "\n******** admin_new ********"
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    puts "\n******** admin_create ********"
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    puts "\n******** admin_delete ********"
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      puts "\n******** set_admin ********"
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      puts "\n******** admin_params ********"
    #   params.fetch(:admin, {})
    end
end
