class TrailsController < ApplicationController
  before_action :set_trail, only: [:show, :edit, :update, :destroy]

  # GET /trails
  # GET /trails.json
  def index
    puts "\n******** trail_index ********"
    # Select distinct trails by name while maintaining unique trail_id
    @trails = Trail.select('DISTINCT ON (name) *')
    puts "@trails.inspect: #{@trails.inspect}"
  end

  # GET /trails/1
  # GET /trails/1.json
  def show
    puts "\n******** trail_show ********"
    puts "*** params.inspect: #{params.inspect} ***"
    gon.js_presence = true
    puts "*** gon.js_presence: #{gon.js_presence} ***"
    gon.selected_trail = @trail.name
    puts "*** gon.selected_trail: #{gon.selected_trail} ***"
    @user = User.find(current_user.id)
    @reports = @trail.reports
    puts "*** @reports.inspect: #{@reports.inspect} ***"
    @report = Report.new
    @tags = @trail.tags
    puts "*** @tags.inspect, #{@tags.inspect} ***"
    session[:trail_id] = @trail.id
    surface_accumulator = 0
    traffic_accumulator = 0
    scenery_accumulator = 0
    overall_rating_accumulator = 0
    @reports.each do |report|
        surface_accumulator += report.surface_rating
        traffic_accumulator += report.traffic_rating
        scenery_accumulator += report.scenery_rating
        overall_rating_accumulator += report.overall_rating
    end
    if @reports.length > 0
        @surface_avg = surface_accumulator / @reports.length
        @traffic_avg = traffic_accumulator / @reports.length
        @scenery_avg = scenery_accumulator / @reports.length
        @overall_rating_avg = overall_rating_accumulator / @reports.length
    else
        @surface_avg = 0
        @traffic_avg = 0
        @scenery_avg = 0
        @overall_rating_avg = 0
    end
    session[:trail_id] = @trail.id
    @photo = Photo.new
    # @photo = Photo.where(user_id: current_user.id).first
    # @photo = Photo.where(trail_id: session[:trail_id]).first
    @photos = Photo.where(trail_id: session[:trail_id])

    puts "@photos: #{@photos}"
    puts "***== @trail.inspect: #{@trail.inspect} ==***"
    puts "@surface_avg: #{@surface_avg}"
    puts "@traffic_avg: #{@wine_avg}"
    puts "@scenery_avg: #{@scenery_avg}"
    puts "@overall_rating_avg: #{@overall_rating_avg}"
    puts "*** session[:trail_id].inspect: #{session[:trail_id].inspect} ***"
    puts "***== @user.inspect, #{@user.inspect} ==***"
  end

  # POST /photos
  # POST /photos.json
  def create_trail_photo
    puts "\n******** photos_create ********"
    puts "photo_params: #{photo_params.inspect}"

    new_params = photo_params
    new_params[:user_id] = current_user.id
    new_params[:trail_id] = session[:trail_id]
    puts "new_params[:user_id]: #{new_params[:user_id]}"
    puts "new_params[:trail_id]: #{new_params[:trail_id]}"
    puts "new_params.inspect: #{new_params.inspect}"

    @photo = Photo.new(new_params)
    puts "@photo.inspect: #{@photo.inspect}"

    respond_to do |format|
      if @photo.save
        puts "+++ Trail Photo Success +++"
        format.html { redirect_to trail_path(session[:trail_id]), notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        puts "+++ Trail Photo Failure +++"
        format.html { render :new, notice: 'Photo was not added.' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /trails/new
  def new
      puts "\n******** trail_new ********"
      @counties = County.all
      @trail = Trail.new
      @tags = Tag.all
      puts "*** @county.inspect: #{@county.inspect} ***"
  end

  # GET /trails/1/edit
  def edit
    puts "\n******** trail_edit ********"
  end

  # POST /trails
  # POST /trails.json
  def create
    puts "\n******** trail_create ********"
    @trail = Trail.new(trail_params)

    respond_to do |format|
      if @trail.save
        puts "+++ Trail Success +++"
        @new_trail = Trail.order("created_at").last
        puts "+++ @new_trail: #{@new_tail} +++"
        format.html { redirect_to trail_path(@new_trail.id)}
        format.html { redirect_to @trail, notice: 'Trail was successfully created.' }
        format.json { render :show, status: :created, location: @trail }
      else
        puts "+++ Trail Fail +++"
        format.html { render :new, notice: 'Trail creation failed.' }
        format.json { render json: @trail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trails/1
  # PATCH/PUT /trails/1.json
  def update
    respond_to do |format|
      if @trail.update(trail_params)
        format.html { redirect_to @trail, notice: 'Trail was successfully updated.' }
        format.json { render :show, status: :ok, location: @trail }
      else
        format.html { render :edit }
        format.json { render json: @trail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trails/1
  # DELETE /trails/1.json
  def destroy
    puts "\n******** trail_delete ********"
    @trail.destroy
    respond_to do |format|
      format.html { redirect_to trails_url, notice: 'Trail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trail
      puts "\n******** set_trail ********"
      @trail = Trail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trail_params
      puts "\n******** trail_params ********"
    #   params.fetch(:trail, {})
      params.require(:trail).permit(:county_id, :csv_id, :name, :length, :surface, :surface_rating, :traffic_rating, :scenery_rating, :overall_rating )
    end

    def photo_params
      puts "\n******** photos_params ********"
      params.require(:photo).permit(:content_type, :caption, :image)
    end

end
