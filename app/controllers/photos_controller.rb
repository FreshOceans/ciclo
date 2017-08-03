class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    puts "\n******** photos_index ********"
    @photos = Photo.order(created_at: :desc)
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    puts "\n******** photos_show ********"
  end

  # GET /photos/new
  def new
    puts "\n******** photos_new ********"
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    puts "\n******** photos_create ********"
    puts "photo_params: #{photo_params.inspect}"

    new_params = photo_params
    new_params[:user_id] = current_user.id
    new_params[:trail_id] = Trail.all.first[:id]
    puts "new_params[:user_id]: #{new_params[:user_id]}"
    puts "new_params[:trail_id]: #{new_params[:trail_id]}"
    puts "new_params.inspect: #{new_params.inspect}"

    @photo = Photo.new(new_params)
    puts "@photo.inspect: #{@photo.inspect}"

    respond_to do |format|
      if @photo.save
        puts "+++ Photo Success +++"
        format.html { redirect_to user_path(current_user.id), notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        puts "+++ Photo Failure +++"
        format.html { render :new, notice: 'Photo was not added.' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    puts "\n******** photos_update ********"
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    puts "\n******** photos_destroy ********"
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      puts "\n******** set_photos ********"
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      puts "\n******** photos_params ********"
    #   params.fetch(:photo, {})
      params.require(:photo).permit(:content_type, :caption, :image)
    end
end
