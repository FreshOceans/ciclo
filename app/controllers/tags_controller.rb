class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  # GET /tags.json
  def index
    puts "\n******** tags_index ********"
    @tags = Tag.all
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    puts "\n******** tags_show ********"
  end

  # GET /tags/new
  def new
    puts "\n******** tags_new ********"
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    puts "\n******** tags_create ********"
    @tag = Tag.new(tag_params)

      if @tag.save
        format.html { redirect_to tags_path, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    puts "\n******** tags_update ********"
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to tags_path,, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    puts "\n******** tags_delete ********"
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      puts "\n******** set_tag ********"
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      puts "\n******** tag_params ********"
    #   params.fetch(:tag, {})
        params.require(:tag).permit(:category_name)
    end
end
